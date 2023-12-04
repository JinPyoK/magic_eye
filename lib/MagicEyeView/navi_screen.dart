import 'package:flutter/material.dart';
import 'package:magic_eye/MagicEyeView/CCTVScreen/cctv_screen.dart';
import 'package:magic_eye/MagicEyeView/MyPageScreen/my_page_screen.dart';
import 'package:magic_eye/MagicEyeView/RecordScreen/record_screen.dart';
import 'package:magic_eye/MagicEyeView/user_info.dart';
import 'package:magic_eye/MagicEyeView/CCTVScreen/cctv_provider.dart';
import 'package:magic_eye/MagicEyeView/RecordScreen/record_provider.dart';
import 'package:provider/provider.dart';
import 'main_provider.dart';

class NaviScreen extends StatefulWidget {
  const NaviScreen({super.key});

  @override
  State<NaviScreen> createState() => _NaviScreenState();
}

class _NaviScreenState extends State<NaviScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    CCTVScreen(),
    RecordScreen(),
    MyPageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MainProvider())],
      child: FutureBuilder(
          future: user,
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text("오류 발생"),
                ),
              );
            } else {
              us = snapshot.data!;
              var json = snapshot.data!.toJson();
              cctvsFromJson = List.from(json['cctvs']);
              recordsFromJson = List.from(json['anormals']);
              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: IndexedStack(
                  index: _selectedIndex,
                  children: _widgetOptions,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.screenshot_monitor_rounded),
                      label: 'CCTV',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.document_scanner_outlined),
                      label: 'Record',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.face),
                      label: 'MY',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.deepPurpleAccent,
                  onTap: _onItemTapped,
                ),
              );
            }
          }),
    );
  }
}
