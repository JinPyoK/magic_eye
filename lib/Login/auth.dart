import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String _errorCode = '';

String getUID() {
  return _auth.currentUser!.uid;
}

Future<String> SignUp({required String email, required String password}) async {
  try {
    UserCredential _usercred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    if (_usercred == null) {
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

Future<String> SignIn({required String email, required String password}) async {
  try {
    UserCredential _usercred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    if (_usercred == null) {
      _errorCode = '서버에 문제가 생겼습니다.';
      return _errorCode;
    }
    return '';
  } on FirebaseAuthException catch (error) {
    switch (error.code) {
      case "user-disabled":
        _errorCode = "계정을 정지되었습니다.";
        break;
      case "invalid-email":
        _errorCode = "유효하지 않은 이메일입니다.";
        break;
      case "user-not-found":
        _errorCode = "해당 계정이 존재하지 않습니다.\n회원가입을 진행해주세요.";
        break;
      case "wrong-password":
        _errorCode = "비밀번호가 다릅니다.";
        break;
      default:
        _errorCode = "에러가 발생했습니다.";
    }
    return _errorCode;
  }
}

Future<void> SignOut() async {
  await _auth.signOut();
}

void Confirm(){
  print(_auth.currentUser!.uid);
}