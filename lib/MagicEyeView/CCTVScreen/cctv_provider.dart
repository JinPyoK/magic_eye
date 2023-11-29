import 'package:flutter/foundation.dart';

class CCTVProvider extends ChangeNotifier {
  String connectAPI = '';
  List<String> menu = ['카메라1', '카메라2'];

  List<String> _api = ['192.168.12.15:8000', '192.168.223.87:8000'];

  void changeAPI(String api) {
    connectAPI = _api[menu.indexOf(api)];
    notifyListeners();
  }

  void addMenu(String newMenu, String newApi) {
    menu.insert(0, newMenu);
    _api.insert(0, newApi);
    connectAPI = newApi;
    notifyListeners();
  }

  void deleteMenu(String deleteMenu) {
    int deleteIndex = menu.indexOf(deleteMenu);
    _api.removeAt(deleteIndex);
    menu.removeAt(deleteIndex);
    notifyListeners();
  }
}
