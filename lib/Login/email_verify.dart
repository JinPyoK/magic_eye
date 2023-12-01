import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Firebase/auth.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({super.key});

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  @override
  Widget build(BuildContext context) {
    navFunction() {
      Navigator.pushNamedAndRemoveUntil(
          context, '/MagicEyeView/NaviScreen', (route) => false);
    }

    renderSnackBar(String code) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.deepPurpleAccent,
          content: Center(
            child: Text(
              code,
              style: const TextStyle(color: Colors.white),
            ),
          )));
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
                  renderSnackBar("이메일을 확인하여 인증해주세요");
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
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    emailVerifiedAndLoginLoading = true;
                  });
                  bool result = await emailVerifiedAndLogin();
                  setState(() {
                    emailVerifiedAndLoginLoading = false;
                  });
                  if (result) {
                    navFunction();
                  } else {
                    renderSnackBar("이메일이 인증되지 않았습니다");
                  }
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 50),
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                child: emailVerifiedAndLoginLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "접속",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ))
          ],
        ),
      ],
    ));
  }
}
