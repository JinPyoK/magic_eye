import 'package:flutter/material.dart';
import 'package:magic_eye/Firebase/database.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

late List<dynamic> cctvsFromJson;

class CCTVProvider extends ChangeNotifier {
  List<dynamic> cctvs = cctvsFromJson;
  List<String> menu =
      cctvsFromJson.map((cctv) => cctv['name'] as String).toList();
  String _connectAPI = '';
  String _connectCam = '';

  VlcPlayerController videoPlayerController = VlcPlayerController.network(
    '',
    hwAcc: HwAcc.full,
    autoPlay: false,
    options: VlcPlayerOptions(),
  );

  Future<void> changeAPI(String api) async {
    int changedIndex = cctvs.indexWhere((cctv) => cctv['name'] == api);
    _connectAPI = cctvs[changedIndex]['ip'];
    _connectCam = menu[changedIndex];
    await fetchCCTV(_connectAPI);
    notifyListeners();
  }

  void addMenu(String newMenu, String newApi) {
    cctvs.insert(0, {"name": newMenu, "ip": newApi});
    menu.insert(0, newMenu);
    updateDB({"cctvs": cctvs});
    _connectAPI = newApi;
    notifyListeners();
  }

  void deleteMenu(String deleteMenu) {
    int deleteIndex = menu.indexOf(deleteMenu);
    menu.removeAt(deleteIndex);
    cctvs.removeAt(deleteIndex);
    updateDB({"cctvs": cctvs});
    initCCTV();
    notifyListeners();
  }

  Future<void> fetchCCTV(String api) async {
    await videoPlayerController.setMediaFromNetwork(api);
  }

  Future<void> initCCTV() async {
    if (menu.isNotEmpty) {
      _connectCam = menu[0];
      _connectAPI = cctvs[0]['ip'];
      await fetchCCTV(_connectAPI);
      notifyListeners();
    }
  }
}
