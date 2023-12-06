import 'package:flutter/material.dart';
import 'package:magic_eye/Firebase/auth.dart';
import 'package:magic_eye/MagicEyeView/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:magic_eye/Firebase/database.dart';

class MyPageUserInfo extends StatefulWidget {
  final double width;
  final double height;

  const MyPageUserInfo(this.width, this.height, {super.key});

  @override
  State<MyPageUserInfo> createState() => _MyPageUserInfoState();
}

class _MyPageUserInfoState extends State<MyPageUserInfo> {
  bool entireAlarm = false;
  bool occupyAlarm = false;
  bool theftAlarm = false;
  bool breakAlarm = false;

  @override
  void initState() {
    super.initState();
    occupyAlarm = us.occupyAlarm ?? false;
    theftAlarm = us.theftAlarm ?? false;
    breakAlarm = us.breakAlarm ?? false;

    if (occupyAlarm || theftAlarm || breakAlarm) {
      entireAlarm = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width / 1.2,
      height: widget.height / 2.2,
      decoration: BoxDecoration(
        color: const Color(0x207C72EC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: widget.height / 40,
            ),
            renderUserName(
                widget.width, context.watch<MainProvider>().displayName),
            const SizedBox(
              height: 20,
            ),
            renderRowWith('계정생성일', Text(getCreationTime())),
            const SizedBox(
              height: 10,
            ),
            renderRowWith('이메일', Text(getEmail())),
            const SizedBox(
              height: 10,
            ),
            renderRowWith('등록 카메라 수',
                Text(context.watch<MainProvider>().cctvs.length.toString())),
            const SizedBox(
              height: 10,
            ),
            renderRowWith(
                '알림 수신',
                SizedBox(
                  height: 30,
                  child: Switch(
                      activeColor: Colors.deepPurpleAccent,
                      value: entireAlarm,
                      onChanged: (val) {
                        setState(
                          () {
                            entireAlarm = val;
                            occupyAlarm = val;
                            theftAlarm = val;
                            breakAlarm = val;
                          },
                        );
                        updateDB({
                          "occupyAlarm": val,
                          "theftAlarm": val,
                          "breakAlarm": val,
                        });
                      }),
                )),
            const SizedBox(
              height: 10,
            ),
            renderRowWith(
                '점거 알림',
                SizedBox(
                  height: 30,
                  child: Switch(
                      activeColor: Colors.deepPurpleAccent,
                      value: occupyAlarm,
                      onChanged: (val) {
                        setState(
                          () {
                            occupyAlarm = val;
                            if (val == true && entireAlarm == false) {
                              entireAlarm = true;
                            }
                          },
                        );
                        updateDB({"occupyAlarm": val});
                      }),
                ),
                16),
            const SizedBox(
              height: 10,
            ),
            renderRowWith(
                '도난 알림',
                SizedBox(
                  height: 30,
                  child: Switch(
                      activeColor: Colors.deepPurpleAccent,
                      value: theftAlarm,
                      onChanged: (val) {
                        setState(
                          () {
                            theftAlarm = val;
                            if (val == true && entireAlarm == false) {
                              entireAlarm = true;
                            }
                          },
                        );
                        updateDB({"theftAlarm": val});
                      }),
                ),
                16),
            const SizedBox(
              height: 10,
            ),
            renderRowWith(
                '파손 알림',
                SizedBox(
                  height: 30,
                  child: Switch(
                      activeColor: Colors.deepPurpleAccent,
                      value: breakAlarm,
                      onChanged: (val) {
                        setState(
                          () {
                            breakAlarm = val;
                            if (val == true && entireAlarm == false) {
                              entireAlarm = true;
                            }
                          },
                        );
                        updateDB({"breakAlarm": val});
                      }),
                ),
                16),
          ],
        ),
      ),
    );
  }
}

renderUserName(double width, String name) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: width / 2,
        child: Center(
          child: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      )
    ],
  );
}

renderRowWith(String key, Widget value, [double padding = 0]) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: padding),
          child: Text(
            key,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        value,
      ],
    ),
  );
}
