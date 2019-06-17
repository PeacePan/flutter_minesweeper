import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/configs.dart';
import 'package:flutter_minesweeper/main.dart';
import 'package:flutter_minesweeper/screens/settings.dart';

const ICON_TITLES = [
  '踩地雷',
  '井字遊戲'
];

class Layout extends StatefulWidget {
  final LayoutState initialState;
  final List<Widget> children;
  Layout({
    this.initialState,
    @required this.children,
  });
  @override
  LayoutState createState() => LayoutState(
    title: this.initialState?.title,
    currentBottomNavIndex: this.initialState?.currentBottomNavIndex,
  );
}

class LayoutState extends State<Layout> {
  final bool hideBottomNav;
  String title;
  int currentBottomNavIndex;
  LayoutState({
    this.title = '',
    this.currentBottomNavIndex = 0,
    this.hideBottomNav = false,
  });
  void updateTitle(String newTitle) {
    setState(() {
      title = newTitle;
    });
  }
  void updateBottomNavIndex(int newIndex) {
    setState(() {
      currentBottomNavIndex = newIndex;
      title = ICON_TITLES[newIndex];
    });
  }
  @override
  void initState() {
    super.initState();
    if (!hideBottomNav) {
      updateTitle(ICON_TITLES[currentBottomNavIndex]);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: onPressSettings,
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Text('離開'),
              onTap: closeApp,
            ),
          ],
        ),
      ),
      body: widget.children[currentBottomNavIndex],
      bottomNavigationBar: hideBottomNav
        ? null
        : BottomNavigationBar(
        currentIndex: currentBottomNavIndex,
        onTap: updateBottomNavIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(ICON_TITLES[0]),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text(ICON_TITLES[1]),
          ),
        ],
      ),
    );
  }
  void closeApp() {
    exit(0);
  }
  void onPressSettings() {
    Navigator.push(context, MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        final state = App.of(context);
        return SettingsScreen(
          configs: state.configs,
          configUpdater: state.updateConfig,
        );
      },
      fullscreenDialog: true,
    ));
  }
}
