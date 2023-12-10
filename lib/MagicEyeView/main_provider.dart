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

  // CCTV Screen
  late List<String> menu =
      List.from(us.cctvs.map((cctv) => cctv['name'] as String).toList());
  String _connectAPI = '';
  String _connectCam = '';

  // CCTV Screen
  VlcPlayerController videoPlayerController = VlcPlayerController.network(
    '',
    hwAcc: HwAcc.full,
    autoPlay: false,
    options: VlcPlayerOptions(),
  );

  // CCTV Screen & MyPage
  String displayName = getDisplayName();

  // Record Screen
  bool refresh = false;

  // Statistics Visitors
  DateTime now = DateTime.now();
  List<int> monthNum = List<int>.generate(12, (index) => 0);
  List<int> dayNum = List<int>.generate(31, (index) => 0);
  List<int> hourNum = List<int>.generate(24, (index) => 0);
  List<int> yearNum = List<int>.generate(4, (index) => 0);

  Future<void> calculateVisitors() async {
    late int month;
    late int day;
    late int hour;
    late int year;
    late int numOfPeople;
    List<String> keys = List.from(userInfo.peopleCount.keys);
    List<Map<dynamic, dynamic>> values = List.from(userInfo.peopleCount.values);

    for (int i = 0; i < keys.length; i++) {
      year = int.parse(keys[i].substring(0, 4));
      month = int.parse(keys[i].substring(5, 7));
      day = int.parse(keys[i].substring(8, 10));
      hour = int.parse(keys[i].substring(11, 13));
      numOfPeople = values[i]['people_count'];

      if (year == now.year) {
        yearNum[3] += numOfPeople;
      } else if (year == now.year - 1) {
        yearNum[2] += numOfPeople;
      } else if (year == now.year - 2) {
        yearNum[1] += numOfPeople;
      } else if (year == now.year - 3) {
        yearNum[0] += numOfPeople;
      }

      if (year == now.year) {
        for (var i = 1; i <= now.month; i++) {
          if (month == i) {
            monthNum[i - 1] += numOfPeople;
            break;
          }
        }
      }

      if (month == now.month) {
        for (var i = 1; i <= now.day; i++) {
          if (day == i) {
            dayNum[i - 1] += numOfPeople;
            break;
          }
        }
      }

      if (day == now.day) {
        for (var i = 0; i <= now.hour; i++) {
          if (hour == i) {
            hourNum[i] += numOfPeople;
            break;
          }
        }
      }
    }
  }

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
