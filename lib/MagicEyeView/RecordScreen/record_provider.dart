import 'package:flutter/material.dart';

late List<dynamic> recordsFromJson;

class RecordProvider extends ChangeNotifier {
  List<dynamic> records = recordsFromJson;

  void dataCollapse(ExpansionTileController controller) {
    controller.collapse();
  }
}
