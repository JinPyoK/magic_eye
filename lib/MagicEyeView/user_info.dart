import 'package:magic_eye/Firebase/database.dart';

class UserInfo {
  final String storeNumber;
  final dynamic cctvs;
  final dynamic anormals;
  final dynamic occupyAlarm;
  final dynamic theftAlarm;
  final dynamic breakAlarm;
  final dynamic peopleCount;
  final dynamic peopleInfo;

  const UserInfo(
      {required this.storeNumber,
      required this.cctvs,
      required this.anormals,
      required this.occupyAlarm,
      required this.theftAlarm,
      required this.breakAlarm,
      required this.peopleCount,
      required this.peopleInfo});

  factory UserInfo.fromJson(Map<dynamic, dynamic> json) {
    return UserInfo(
      storeNumber: json["storeNumber"] ?? '',
      cctvs: json["cctvs"] ?? [],
      anormals: json["anormals"] ?? [],
      occupyAlarm: json['occupyAlarm'] ?? false,
      theftAlarm: json['theftAlarm'] ?? false,
      breakAlarm: json['breakAlarm'] ?? false,
      peopleCount: json['people_count'] ?? {},
      peopleInfo: json['people_info'] ?? {},
    );
  }

  factory UserInfo.fromNull() {
    return const UserInfo(
      storeNumber: '',
      cctvs: [],
      anormals: [],
      occupyAlarm: false,
      theftAlarm: false,
      breakAlarm: false,
      peopleCount: {},
      peopleInfo: {},
    );
  }

  Map<String, dynamic> toJson() => {
        "storeNumber": storeNumber,
        "cctvs": cctvs,
        "anormals": anormals,
        "occupyAlarm": occupyAlarm,
        "theftAlarm": theftAlarm,
        "breakAlarm": breakAlarm,
        "people_count": peopleCount,
        "people_info": peopleInfo,
      };
}

late Future<UserInfo> user;

Future<void> getUserInfo() async {
  user = getDB();
}
