import 'package:flutter/material.dart';
import 'user_info.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:magic_eye/Firebase/database.dart';
import 'package:magic_eye/Firebase/auth.dart';

late UserInfo us;

class MainProvider extends ChangeNotifier {
  late UserInfo userInfo = us;
  late List<dynamic> records = List.from(us.anormals);
  late List<dynamic> cctvs = List.from(us.cctvs);
  late List<String> menu =
      List.from(us.cctvs.map((cctv) => cctv['name'] as String).toList());
  String _connectAPI = '';
  String _connectCam = '';

  String displayName = getDisplayName();

  bool refresh = false;

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

  Future<void> refreshData() async {
    refresh = true;
    notifyListeners();
    userInfo = await getDB();
    records = List.from(userInfo.anormals);
    cctvs = List.from(userInfo.cctvs);
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

  void changeDisplayName(String newDisplayName) {
    displayName = newDisplayName;
    notifyListeners();
  }

  void dataCollapse(ExpansionTileController controller) {
    controller.collapse();
  }
}
