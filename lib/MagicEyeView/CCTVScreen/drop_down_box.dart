import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'menu_setting.dart';
import 'package:magic_eye/MagicEyeView/main_provider.dart';

class Menu extends StatefulWidget {
  final double width;

  const Menu(this.width, {super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return context.watch<MainProvider>().menu.isNotEmpty
        ? DropdownMenu(
            width: widget.width,
            menuHeight: 135,
            label: const Text("CCTV"),
            hintText: "설정 버튼을 눌러 CCTV 추가",
            trailingIcon: menuIcon(context),
            selectedTrailingIcon: const Icon(Icons.menu_outlined),
            initialSelection: context.watch<MainProvider>().menu.first,
            onSelected: (String? val) {
              context.read<MainProvider>().changeAPI(val!);
            },
            dropdownMenuEntries: context
                .watch<MainProvider>()
                .menu
                .map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff7C72EC),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              fixedSize: Size(widget.width / 1.1, 50),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MenuSetting(),
                  ));
            },
            child: const Text(
              "CCTV 추가하기",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ));
  }
}

menuIcon(BuildContext context) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MenuSetting(),
            ));
      },
      child: const Icon(Icons.settings));
}
