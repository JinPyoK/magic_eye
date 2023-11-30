import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cctv_provider.dart';
import 'menu_setting.dart';

class Menu extends StatefulWidget {
  final double width;

  const Menu(this.width, {super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return context.watch<CCTVProvider>().menu.isNotEmpty
        ? DropdownMenu(
            width: widget.width,
            menuHeight: 135,
            label: const Text("CCTV"),
            hintText: "설정 버튼을 눌러 CCTV 추가",
            trailingIcon: menuIcon(context),
            selectedTrailingIcon: const Icon(Icons.menu_outlined),
            initialSelection: context.watch<CCTVProvider>().menu.first,
            onSelected: (String? val) {
              context.read<CCTVProvider>().changeAPI(val!);
            },
            dropdownMenuEntries: context
                .watch<CCTVProvider>()
                .menu
                .map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              fixedSize: Size(widget.width / 1.4, 50),
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
