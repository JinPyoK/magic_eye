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
      return UserInfo.fromNull();
    }
    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    return UserInfo.fromJson(values);
  } on Exception catch (_) {
    return UserInfo.fromNull();
  }
}
