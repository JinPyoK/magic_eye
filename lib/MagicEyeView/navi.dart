import 'package:flutter/material.dart';
import 'package:magic_eye/MagicEyeView/user_info.dart';
import 'CCTVScreen/cctv_screen.dart';
import 'MyPageScreen/my_page_screen.dart';
import 'RecordScreen/record_screen.dart';
import 'StatisticsScreen/statistics_screen.dart';
import 'main_provider.dart';
import 'package:provider/provider.dart';

class Navi extends StatefulWidget {
  const Navi({super.key});

  @override
  State<Navi> createState() => _NaviState();
}

class _NaviState extends State<Navi> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    CCTVScreen(),
    RecordScreen(),
    StatisticsScreen(),
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
    return FutureBuilder(
        future: user,
        builder: (context, snapshot) {
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
            context.read<MainProvider>().calculateVisitors();
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
                    icon: Icon(Icons.analytics_outlined),
                    label: 'Statistics',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.face),
                    label: 'MY',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.deepPurpleAccent,
                unselectedItemColor: Colors.black,
                onTap: _onItemTapped,
              ),
            );
          }
        });
  }
}
