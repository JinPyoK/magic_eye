import 'package:flutter/material.dart';
import 'package:magic_eye/Firebase/database.dart';

late List<dynamic> recordsFromJson;

class RecordProvider extends ChangeNotifier {
  List<dynamic> records = recordsFromJson;
  bool refresh = false;

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

  Future<void> refreshRecordData() async {
    refresh = true;
    notifyListeners();
    var recordsData = await getDB();
    records = List.from(recordsData.anormals);
    refresh = false;
    notifyListeners();
  }

  void dataCollapse(ExpansionTileController controller) {
    controller.collapse();
  }
}
