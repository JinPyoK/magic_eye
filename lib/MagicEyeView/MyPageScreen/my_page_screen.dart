import 'package:flutter/material.dart';
import 'package:magic_eye/Firebase/auth.dart';
import 'package:magic_eye/MagicEyeView/RecordScreen/record_provider.dart';
import 'package:magic_eye/Firebase/database.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    navFunction() {
      Navigator.pushNamedAndRemoveUntil(
          context, "/Login/SignIn", (route) => false);
    }

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ElevatedButton(
                onPressed: () {
                  print(recordsFromJson);
                },
                child: const Text("확인 출력")),
            ElevatedButton(
                onPressed: () async {
                  await updateDB({
                    'anormals': [
                      {
                        'date': "2023-09-18 09:45",
                        'type': 'occupy',
                        'video': 'videoURL1'
                      },
                      {
                        'date': "2023-05-23 17:12",
                        'type': 'theft',
                        'video': 'videoURL2'
                      },
                      {
                        'date': "2022-07-02 15:36",
                        'type': 'break',
                        'video': 'videoURL3'
                      },
                    ]
                  });
                },
                child: const Text("정보저장")),
          ],
        ),
      ),
    );
  }
}
