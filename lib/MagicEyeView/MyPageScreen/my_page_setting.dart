import 'package:flutter/material.dart';
import 'package:magic_eye/Firebase/auth.dart';
import 'package:magic_eye/Firebase/database.dart';

class MyPageSetting extends StatefulWidget {
  const MyPageSetting({super.key});

  @override
  State<MyPageSetting> createState() => _MyPageSettingState();
}

class _MyPageSettingState extends State<MyPageSetting> {
  final displayNameKey = GlobalKey<FormState>();
  final storeNumberKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    navFunction() {
      Navigator.pushNamedAndRemoveUntil(
          context, '/Login/SignIn', (route) => false);
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, box) {
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
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

renderTextFormField({
  required GlobalKey<FormState> formKey,
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
          obscureText: label == '비밀번호' ? true : false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onSaved: onSaved,
          validator: validator,
          onTap: () {
            formKey.currentState!.save();
          },
          decoration: InputDecoration(
            labelText: label,
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
