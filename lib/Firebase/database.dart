import 'package:firebase_database/firebase_database.dart';
import 'auth.dart';
import '../MagicEyeView/user_info.dart';

final FirebaseDatabase _db = FirebaseDatabase.instance;

Future<void> updateDB(Map<String, dynamic> data) async {
  try {
    await _db.ref().child("users").child(getUID()).update(data);
  } on Exception catch (_) {
    return;
  }
}

Future<UserInfo> getDB() async {
  try {
    var snapshot = await _db.ref().child("users").child(getUID()).get();
    if (snapshot.value == null) {
      print("sadfasdf");
      return UserInfo.fromNull();
    }
    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    return UserInfo.fromJson(values);
  } on Exception catch (_) {
    return UserInfo.fromNull();
  }
}

Future<void> testDB() async {
  var snapshot = await _db.ref().child("asdfsadf").child(getUID()).get();
  print(snapshot.value);
}
