import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String _errorCode = '';

bool signUpLoading = false;
bool signInLoading = false;

String getUID() {
  return _auth.currentUser!.uid;
}

bool isLogin() {
  if (_auth.currentUser == null) {
    return false;
  } else {
    return true;
  }
}

Future<String> signUp({required String email, required String password}) async {
  try {
    UserCredential usercred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    if (usercred == null) {
      _errorCode = '서버에 문제가 생겼습니다.';
      return _errorCode;
    }
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
    UserCredential usercred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    if (usercred == null) {
      _errorCode = '서버에 문제가 생겼습니다.';
      return _errorCode;
    }
    return '';
  } on FirebaseAuthException catch (error) {
    _errorCode = "오류가 발생했습니다 (${error.code})";
    return _errorCode;
  }
}

Future<void> signOut() async {
  await _auth.signOut();
}

void confirm(){
  if (_auth.currentUser == null) {
    print('null입니다');
  } else {
    print(_auth.currentUser!.uid);
  }
}