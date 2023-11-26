import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({super.key});

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 8,
            alignment: Alignment.bottomLeft,
            child: const Text(
              "로그인",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
              key: formKey,
              child: Column(
                children: [
                  renderTextFormField(
                    label: '이메일',
                    hint: '이메일을 입력해주세요',
                    onSaved: (val) {},
                    validator: (val) {
                      if (val.length < 1) {
                        return '필수 사항입니다.';
                      } else if (!isEmail(val)) {
                        return '이메일 형식으로 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  renderTextFormField(
                    label: '비밀번호',
                    hint: '비밀번호를 입력해주세요',
                    onSaved: (val) {},
                    validator: (val) {
                      if (val.length < 1) {
                        return '필수 사항입니다.';
                      } else if (val.length < 6) {
                        return '6자 이상 입력해주세요';
                      }
                      return null;
                    },
                  ),
                ],
              )),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff7C72EC),
              foregroundColor: Colors.white,
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              fixedSize: const Size(300, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text("로그인"),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 130,
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "또는",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 130,
                height: 1,
                color: Colors.grey,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Login/SignUp');
                  },
                  child: const Text("회원가입")),
              const SizedBox(
                width: 50,
              ),
              TextButton(onPressed: () {}, child: const Text("이메일 찾기")),
              TextButton(onPressed: () {}, child: const Text("비밀번호 찾기")),
            ],
          )
        ],
      ),
    );
  }

  renderTextFormField({
    required String label,
    required String hint,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
  }) {
    return SizedBox(
      width: 300,
      height: 120,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.always,
            onSaved: onSaved,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
