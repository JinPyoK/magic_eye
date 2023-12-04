import 'package:flutter/material.dart';
import 'user_info.dart';
import 'package:magic_eye/Firebase/database.dart';

late UserInfo us;

class MainProvider extends ChangeNotifier {
  UserInfo userInfo = us;
  List<dynamic> records = List.from(us.anormals);
  List<dynamic> cctvs = List.from(us.cctvs);

  bool refresh = false;

  Future<void> refreshRecordData() async {
    refresh = true;
    notifyListeners();
    us = await getDB();
    records = List.from(us.anormals);
    cctvs = List.from(us.cctvs);
    refresh = false;
    notifyListeners();
  }

  void deleteData(String date, String cam, String type, String videoURL) {
    records.removeAt(records.indexWhere((record) {
      if (record['date'] == date &&
          record['cam'] == cam &&
          record['type'] == type &&
          record['videoURL'] == videoURL) {
        return true;
      } else {
        return false;
      }
    }));
    updateDB({'anormals': records});
    notifyListeners();
  }
}
