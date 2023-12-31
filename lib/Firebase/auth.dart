import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String _errorCode = '';

bool signUpLoading = false;
bool signInLoading = false;
bool signOutLoading = false;
bool emailVerifyLoading = false;
bool updatePasswordLoading = false;
bool resetPasswordLoading = false;
bool updateDisplayNameLoading = false;
bool emailVerifiedAndLoginLoading = false;

bool googleLogin = false;

String _tempEmail = '';
String _tempPassword = '';

String getUID() {
  if (_auth.currentUser == null) {
    return 'NO UID';
  }
  return _auth.currentUser!.uid;
}

String getDisplayName() {
  if (_auth.currentUser != null) {
    return _auth.currentUser!.displayName!;
  } else {
    return '';
  }
}

String getCreationTime() {
  if (_auth.currentUser != null) {
    DateTime dt = _auth.currentUser!.metadata.creationTime!;
    String creationTime = '${dt.year}.${dt.month}.${dt.day}';
    return creationTime;
  } else {
    return '';
  }
}

String getEmail() {
  if (_auth.currentUser != null) {
    return _auth.currentUser!.email!;
  } else {
    return '';
  }
}

bool isEmailVerified() {
  if (_auth.currentUser == null) {
    return false;
  }
  return _auth.currentUser!.emailVerified;
}

bool isLogin() {
  if (_auth.currentUser == null) {
    return false;
  } else {
    return true;
  }
}

Future<bool> emailVerifiedAndLogin() async {
  await signOut();
  await signIn(email: _tempEmail, password: _tempPassword);
  if (isEmailVerified()) {
    _tempEmail = '';
    _tempPassword = '';
    return true;
  } else {
    return false;
  }
}

Future<String> signUp(
    {required String email,
    required String password,
    required String displayName}) async {
  try {
    UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (userCred == null) {
      _errorCode = '서버에 문제가 생겼습니다.';
      return _errorCode;
    }
    await updateDisplayName(newDisplayName: displayName);
    _tempEmail = email;
    _tempPassword = password;
    return '';
  } on FirebaseAuthException catch (error) {
    switch (error.code) {
      case "email-already-in-use":
        _errorCode = "계정을 이미 사용중입니다!";
        break;
      case "invalid-email":
        _errorCode = "유효하지 않은 이메일입니다.";
        break;
      case "weak-password":
        _errorCode = "비밀번호가 취약합니다.\n다시 입력해주세요.";
        break;
      case "operation-not-allowed":
        _errorCode = "잘못된 입력입니다.";
        break;
      default:
        _errorCode = "에러가 발생했습니다.";
    }
    return _errorCode;
  }
}

Future<String> signIn({required String email, required String password}) async {
  try {
    UserCredential userCred = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    if (userCred == null) {
      _errorCode = '서버에 문제가 생겼습니다.';
      return _errorCode;
    }
    if (!isEmailVerified()) {
      _tempEmail = email;
      _tempPassword = password;
    }
    return '';
  } on FirebaseAuthException catch (error) {
    _errorCode = "오류가 발생했습니다 (${error.code})";
    return _errorCode;
  }
}

Future<String> signInWithGoogle() async {
  // Trigger the authentication flow
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await _auth.signInWithCredential(credential);

    _errorCode = '';
    return _errorCode;
  } on Exception catch (_) {
    _errorCode = '구글 로그인 오류';
    return _errorCode;
  }
}

Future<void> emailVerify() async {
  try {
    if (_auth.currentUser != null) {
      await _auth.currentUser!.sendEmailVerification();
    }
  } on FirebaseAuthException catch (_) {
    return;
  }
}

Future<String> updatePassword({required String newPassword}) async {
  try {
    if (_auth.currentUser != null) {
      await _auth.currentUser!.updatePassword(newPassword);
      _errorCode = '';
      return _errorCode;
    }
    _errorCode = '계정이 존재하지 않습니다';
    return _errorCode;
  } on FirebaseAuthException catch (_) {
    _errorCode = '에러가 발생했습니다';
    return _errorCode;
  }
}

Future<String> resetPassword({required String email}) async {
  try {
    await _auth.sendPasswordResetEmail(email: email);
    _errorCode = '';
    return _errorCode;
  } on FirebaseAuthException catch (error) {
    _errorCode = error.code;
    return _errorCode;
  }
}

Future<void> signOut() async {
  try {
    if (_auth.currentUser != null) {
      await _auth.signOut();
    }
    if (googleLogin) {
      await GoogleSignIn().disconnect();
      await GoogleSignIn().signOut();
      googleLogin = false;
    }
  } on FirebaseAuthException catch (_) {
    return;
  }
}

Future<String> updateDisplayName({required String newDisplayName}) async {
  try {
    await _auth.currentUser!.updateDisplayName(newDisplayName);
    _errorCode = '';
    return _errorCode;
  } on Exception catch (_) {
    _errorCode = '에러가 발생했습니다';
    return _errorCode;
  }
}
