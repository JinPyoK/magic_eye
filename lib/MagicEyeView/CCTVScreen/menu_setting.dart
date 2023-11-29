import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cctv_provider.dart';

class MenuSetting extends StatefulWidget {
  const MenuSetting({super.key});

  @override
  State<MenuSetting> createState() => _MenuSettingState();
}

class _MenuSettingState extends State<MenuSetting> {
  final formKey = GlobalKey<FormState>();

  String name = '';
  String ip = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (_, box) {
          final width = box.maxWidth;
          final height = box.maxHeight;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: height / 18,
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          renderTextFormField(
                            width: width,
                            label: '이름',
                            hint: 'CCTV의 이름을 정해주세요',
                            onSaved: (val) {
                              name = val;
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '필수 사항입니다.';
                              }
                              return null;
                            },
                          ),
                          renderTextFormField(
                            width: width,
                            label: 'IP',
                            hint: 'CCTV의 IP주소를 입력해주세요.',
                            onSaved: (val) {
                              ip = val;
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '필수 사항입니다.';
                              }
                              return null;
                            },
                          ),
                        ],
                      )),
                  SizedBox(
                    width: width / 1.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("나가기")),
                        ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                context.read<CCTVProvider>().addMenu(name, ip);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("CCTV 추가")),
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  renderTextFormField({
    required double width,
    required String label,
    required String hint,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
  }) {
    return SizedBox(
      width: width / 1.2,
      height: 120,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
        ],
      ),
    );
  }
}
