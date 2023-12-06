import 'package:flutter/material.dart';
import 'package:magic_eye/Firebase/auth.dart';
import 'package:magic_eye/Firebase/database.dart';
import 'package:magic_eye/MagicEyeView/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class MyPageSetting extends StatefulWidget {
  const MyPageSetting({super.key});

  @override
  State<MyPageSetting> createState() => _MyPageSettingState();
}

class _MyPageSettingState extends State<MyPageSetting> {
  final displayNameKey = GlobalKey<FormState>();
  final storeNumberKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();

  String newDisplayName = '';
  String newStoreNumber = '';
  String newPassword = '';

  @override
  Widget build(BuildContext context) {
    navFunction() {
      Navigator.pushNamedAndRemoveUntil(
          context, '/Login/SignIn', (route) => false);
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

    focusOut() {
      FocusScope.of(context).unfocus();
    }

    updateState() {
      context.read<MainProvider>().changeDisplayName(newDisplayName);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, box) {
          final width = box.maxWidth;
          final height = box.maxHeight;
          return Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              children: [
                SizedBox(
                  height: height / 25,
                ),
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
                ),
                const SizedBox(
                  height: 20,
                ),
                renderTextFormField(
                    width: width,
                    formKey: displayNameKey,
                    label: '닉네임 변경',
                    hint: getDisplayName(),
                    onSaved: (val) {
                      setState(() {
                        newDisplayName = val;
                      });
                    },
                    validator: (val) {
                      if (val.length < 1) {
                        return '필수 사항입니다.';
                      } else if (val.length > 10) {
                        return '10자 이하로 작성해주세요.';
                      }
                      return null;
                    },
                    onPressed: () async {
                      if (displayNameKey.currentState!.validate()) {
                        displayNameKey.currentState!.save();
                        focusOut();
                        setState(() {
                          updateDisplayNameLoading = true;
                        });
                        var errorCode = await updateDisplayName(
                            newDisplayName: newDisplayName);
                        setState(() {
                          updateDisplayNameLoading = false;
                        });
                        if (errorCode == '') {
                          renderSnackBar("닉네임을 변경하였습니다.");
                          updateState();
                        } else {
                          renderSnackBar(errorCode);
                        }
                      }
                    },
                    loading: updateDisplayNameLoading),
                const SizedBox(
                  height: 20,
                ),
                renderTextFormField(
                    width: width,
                    formKey: passwordKey,
                    label: '비밀번호 변경',
                    hint: '',
                    onSaved: (val) {
                      setState(() {
                        newPassword = val;
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
                    onPressed: () async {
                      if (passwordKey.currentState!.validate()) {
                        passwordKey.currentState!.save();
                        focusOut();
                        setState(() {
                          updatePasswordLoading = true;
                        });
                        var errorCode =
                            await updatePassword(newPassword: newPassword);
                        setState(() {
                          updatePasswordLoading = false;
                        });
                        if (errorCode == '') {
                          renderSnackBar("비밀번호를 변경하였습니다.");
                        } else {
                          renderSnackBar(errorCode);
                        }
                      }
                    },
                    loading: updatePasswordLoading),
              ],
            ),
          );
        },
      ),
    );
  }
}

renderTextFormField({
  required double width,
  required GlobalKey<FormState> formKey,
  required String label,
  required String hint,
  required FormFieldSetter onSaved,
  required FormFieldValidator validator,
  required VoidCallback onPressed,
  required bool loading,
}) {
  return Column(
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width / 1.6,
            child: Form(
              key: formKey,
              child: TextFormField(
                obscureText: label == '비밀번호 변경' ? true : false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  fixedSize: Size(width / 5, 45)),
              onPressed: onPressed,
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ))
        ],
      ),
    ],
  );
}
