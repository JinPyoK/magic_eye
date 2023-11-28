import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
              ),
              Image.asset('assets/logo.png'),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "MagicEye",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              const Text(
                "안전한 매장관리의 첫걸음",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 200,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Login/SignIn');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7C72EC),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  fixedSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text("시작하기"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
