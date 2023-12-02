import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:magic_eye/Firebase/database.dart';

late List<dynamic> cctvs;

class CCTVProvider extends ChangeNotifier {
  List<dynamic> cctvss = cctvs;
  List<String> menu = cctvs.map((cctv) => cctv['name'] as String).toList();

  String _connectAPI = '';
  final _dio = Dio();

  void changeAPI(String api) {
    _connectAPI = cctvs[cctvs.indexWhere((cctv) => cctv['name'] == api)]['ip'];
    notifyListeners();
  }

  void addMenu(String newMenu, String newApi) {
    cctvss.insert(0, {"name": newMenu, "ip": newApi});
    menu.insert(0, newMenu);
    updateDB({"cctvs": cctvss});
    _connectAPI = newApi;
    notifyListeners();
  }

  void deleteMenu(String deleteMenu) {
    int deleteIndex = menu.indexOf(deleteMenu);
    menu.removeAt(deleteIndex);
    cctvss.removeAt(deleteIndex);
    updateDB({"cctvs": cctvss});
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
