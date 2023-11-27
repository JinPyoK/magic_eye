import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import '../Firebase/auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();

  String email = '';

  @override
  Widget build(BuildContext context) {
    focusOut() {
      FocusScope.of(context).unfocus();
    }
    var snack = ScaffoldMessenger.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 8,
                alignment: Alignment.bottomLeft,
                child: const Text(
                  "비밀번호 초기화",
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
                        onSaved: (val) {
                          email = val;
                        },
                        validator: (val) {
                          if (val.length < 1) {
                            return '필수 사항입니다.';
                          } else if (!isEmail(val)) {
                            return '이메일 형식으로 입력해주세요';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    setState(() {
                      resetPasswordLoading = true;
                    });
                    focusOut();
                    await resetPassword(email: email);
                    snack.showSnackBar(const SnackBar(backgroundColor: Colors.deepPurpleAccent,
                        content: Text("이메일을 확인하여 비밀번호 초기화를 진행하세요", style: TextStyle(color: Colors.white, fontSize: 16))));
                    setState(() {
                      resetPasswordLoading = false;
                    });
                  }
                },
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
                child: resetPasswordLoading
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : const Text("비밀번호 초기화"),
              ),
            ],
          ),
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
