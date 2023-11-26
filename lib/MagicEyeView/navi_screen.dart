import 'package:flutter/material.dart';
import '../Login/auth.dart';

class NaviScreen extends StatelessWidget {
  const NaviScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var snack = ScaffoldMessenger.of(context);
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              Confirm();
            }, child: const Text("로그아웃")),
            const SizedBox(width: 100,),
            ElevatedButton(onPressed: () async {
              var errorCode = await SignUp(email: "kjp527@google.com", password: "12345678");
              if (errorCode != '') {
                snack.showSnackBar(SnackBar(content: Text(errorCode, style: const TextStyle(color: Colors.white),), backgroundColor: Colors.deepPurpleAccent,));
              }
            }, child: const Text("상태")),
          ],
        ),
      ),
    );
  }
}
