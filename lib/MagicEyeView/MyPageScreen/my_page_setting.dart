import 'package:flutter/material.dart';
import 'package:magic_eye/Firebase/auth.dart';
import 'package:magic_eye/Firebase/database.dart';

class MyPageSetting extends StatefulWidget {
  const MyPageSetting({super.key});

  @override
  State<MyPageSetting> createState() => _MyPageSettingState();
}

class _MyPageSettingState extends State<MyPageSetting> {
  @override
  Widget build(BuildContext context) {
    navFunction() {
      Navigator.pushNamedAndRemoveUntil(
          context, '/Login/SignIn', (route) => false);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.backspace_outlined)),
                ElevatedButton(
                    onPressed: () async {
                      await updateDB({
                        'anormals': [
                          {
                            'date': "2023-09-18 09:45",
                            'cam': "cam1",
                            'type': 'occupy',
                            'videoURL': 'videoURL1'
                          },
                          {
                            'date': "2023-05-23 17:12",
                            'cam': "cam1",
                            'type': 'theft',
                            'videoURL': 'videoURL2'
                          },
                          {
                            'date': "2022-07-02 15:36",
                            'cam': "cam2",
                            'type': 'break',
                            'videoURL': 'videoURL3'
                          },
                        ]
                      });
                    },
                    child: const Text("정보저장")),
                ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        signOutLoading = true;
                      });

                      await signOut();
                      setState(() {
                        signOutLoading = false;
                      });
                      navFunction();
                    },
                    child: signOutLoading
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : const Text("로그아웃")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
