import 'package:magic_eye/Firebase/database.dart';

class UserInfo {
  final String storeNumber;
  final dynamic cctvs;
  final dynamic anormals;
  final dynamic occupyAlarm;
  final dynamic theftAlarm;
  final dynamic breakAlarm;

  const UserInfo({
    required this.storeNumber,
    required this.cctvs,
    required this.anormals,
    required this.occupyAlarm,
    required this.theftAlarm,
    required this.breakAlarm,
  });

  factory UserInfo.fromJson(Map<dynamic, dynamic> json) {
    return UserInfo(
      storeNumber: json["storeNumber"] ?? '',
      cctvs: json["cctvs"] ?? [],
      anormals: json["anormals"] ?? [],
      occupyAlarm: json['occupyAlarm'] ?? false,
      theftAlarm: json['theftAlarm'] ?? false,
      breakAlarm: json['breakAlarm'] ?? false,
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
    );
  }

  Map<String, dynamic> toJson() => {
        "storeNumber": storeNumber,
        "cctvs": cctvs,
        "anormals": anormals,
        "occupyAlarm": occupyAlarm,
        "theftAlarm": theftAlarm,
        "breakAlarm": breakAlarm,
      };
}

late Future<UserInfo> user;

Future<void> getUserInfo() async {
  user = getDB();
}
