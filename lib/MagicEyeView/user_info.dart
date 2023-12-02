import 'package:magic_eye/Firebase/database.dart';

class UserInfo {
  final String storeNumber;
  final dynamic cctvs;
  final dynamic anormals;

  const UserInfo({
    required this.storeNumber,
    required this.cctvs,
    required this.anormals,
  });

  factory UserInfo.fromJson(Map<dynamic, dynamic> json) {
    return UserInfo(
      storeNumber: json["storeNumber"],
      cctvs: json["cctvs"],
      anormals: json["anormals"],
    );
  }

  factory UserInfo.fromNull() {
    return const UserInfo(
      storeNumber: '',
      cctvs: <dynamic>[],
      anormals: <dynamic>[],
    );
  }

  Map<String, dynamic> toJson() => {
        "storeNumber": storeNumber,
        "cctvs": cctvs,
        "anormals": anormals,
      };
}

late Future<UserInfo> user;

Future<void> getUserInfo() async {
  user = getDB();
}
