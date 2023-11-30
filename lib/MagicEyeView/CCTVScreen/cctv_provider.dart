import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class CCTVProvider extends ChangeNotifier {
  List<String> menu = ['카메라1', '카메라2'];
  List<String> _api = ['192.168.12.15:8000', '192.168.223.87:8000'];

  String _connectAPI = '';
  final _dio = Dio();

  void changeAPI(String api) {
    _connectAPI = _api[menu.indexOf(api)];
    notifyListeners();
  }

  void addMenu(String newMenu, String newApi) {
    menu.insert(0, newMenu);
    _api.insert(0, newApi);
    _connectAPI = newApi;
    notifyListeners();
  }

  void deleteMenu(String deleteMenu) {
    int deleteIndex = menu.indexOf(deleteMenu);
    _api.removeAt(deleteIndex);
    menu.removeAt(deleteIndex);
    notifyListeners();
  }

  Stream<int> fetchCCTV() async* {
    if (_connectAPI == '192.168.12.15:8000') {
      for (var i = 0; i < 10; i++) {
        await Future.delayed(const Duration(seconds: 1));
        yield i;
      }
    } else if (_connectAPI == '192.168.223.87:8000') {
      for (var i = 20; i < 30; i++) {
        await Future.delayed(const Duration(seconds: 1));
        yield i;
      }
    }

    // yield _dio.get(_connectAPI);
  }
}
