import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String passwordConfirm = '';
  String name = '';
  String storeNumber = '';

  @override
  Widget build(BuildContext context) {
    var snack = ScaffoldMessenger.of(context);
    navFunction() {
      Navigator.pushNamedAndRemoveUntil(
          context, '/MagicEyeView/NaviScreen', (route) => false);
    }

    focusOut() {
      FocusScope.of(context).unfocus();
    }

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
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Colors.black
                //   )
                // ),
                child: const Text(
                  "회원가입",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      renderTextFormField(
                        label: '이메일',
                        hint: '예) email@google.com',
                        onSaved: (val) {
                          setState(() {
                            email = val;
                          });
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
                      renderTextFormField(
                        label: '비밀번호',
                        hint: '영문, 숫자 조합 8~16자',
                        onSaved: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        validator: (val) {
                          if (val.length < 1) {
                            return '필수 사항입니다.';
                          } else if (val.length < 8 ||
                              val.length > 16 ||
                              isAlpha(val) ||
                              isNumeric(val)) {
                            return '영문, 숫자 조합 8~16자';
                          }
                          return null;
                        },
                      ),
                      renderTextFormField(
                        label: '비밀번호 확인',
                        hint: '비밀번호를 한번 더 입력해주세요',
                        onSaved: (val) {
                          setState(() {
                            passwordConfirm = val;
                          });
                        },
                        validator: (val) {
                          if (val.length < 1) {
                            return '필수 사항입니다.';
                          } else if (password != passwordConfirm) {
                            return '비밀번호가 다릅니다!';
                          }
                          return null;
                        },
                      ),
                      renderTextFormField(
                        label: '이름',
                        hint: '예) 홍길동',
                        onSaved: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                        validator: (val) {
                          if (val.length < 1) {
                            return '필수 사항입니다.';
                          }
                          return null;
                        },
                      ),
                      renderTextFormField(
                        label: '매장 번호',
                        hint: '영문, 숫자 조합 10자',
                        onSaved: (val) {
                          setState(() {
                            storeNumber = val;
                          });
                        },
                        validator: (val) {
                          if (val.length < 1) {
                            return '필수 사항입니다.';
                          }
                          if (val.length < 10) {
                            return '10자 이상 입력해주세요';
                          }
                          if (isAlpha(val) || isNumeric(val)) {
                            return '영문 숫자 조합으로 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    focusOut();
                    setState(() {
                      signUpLoading = true;
                    });
                    var errorCode =
                        await signUp(email: email, password: password);
                    setState(() {
                      signUpLoading = false;
                    });
                    if (errorCode != '') {
                      snack.showSnackBar(SnackBar(
                          backgroundColor: Colors.deepPurpleAccent,
                          content: Center(
                            child: Text(
                              errorCode,
                              style: const TextStyle(color: Colors.white),
                            ),
                          )));
                    } else {
                      navFunction();
                    }
                  }
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
                child: signUpLoading ? const CircularProgressIndicator(color: Colors.white,) : const Text("회원가입"),
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
            onTap: () {
              formKey.currentState!.save();
            },
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
