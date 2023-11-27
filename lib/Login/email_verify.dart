import 'package:flutter/material.dart';
import '../Firebase/auth.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({super.key});

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  @override
  Widget build(BuildContext context) {
    var snack = ScaffoldMessenger.of(context);
    navFunction() {
      Navigator.pushNamedAndRemoveUntil(
          context, '/MagicEyeView/NaviScreen', (route) => false);
    }
    return Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "이메일을 인증해주세요",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    emailVerifyLoading = true;
                  });
                  await emailVerify();
                  setState(() {
                    emailVerifyLoading = false;
                  });
                  snack.showSnackBar(const SnackBar(
                      backgroundColor: Colors.deepPurpleAccent,
                      content: Text(
                        "이메일을 확인하여 인증해주세요",
                        style: TextStyle(color: Colors.white),
                      )));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  fixedSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: emailVerifyLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "이메일 인증하기",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      )),
            const SizedBox(height: 50,),
            ElevatedButton(onPressed: () {
              if (isEmailVerified()) {
                navFunction();
              } else {
                snack.showSnackBar(const SnackBar(
                    backgroundColor: Colors.deepPurpleAccent,
                    content: Text(
                      "이메일 인증이 진행되지 않았습니다",
                      style: TextStyle(color: Colors.white),
                    )));
              }
            }, style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 50),
              backgroundColor: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )
            )
                ,child: const Text(
              "접속",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ))
          ],
        ),
      ],
    ));
  }
}
