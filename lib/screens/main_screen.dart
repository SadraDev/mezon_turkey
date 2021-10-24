import 'package:flutter/material.dart';
import 'package:mezon_turkey/CustomStuff/navigationbar.dart';
import 'package:mezon_turkey/CustomStuff/drawer.dart';
import 'package:mezon_turkey/admin/admin_screen.dart';
import 'package:mezon_turkey/screens/cloth_screen.dart';
import 'package:mezon_turkey/screens/home_screen.dart';
import 'package:mezon_turkey/screens/shoe_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String id = 'main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isChecked = true;
  int selectedIndex = 1;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  _screenOptions(int index) {
    if (index == 0) {
      return ShoeScreen(isChecked: isChecked);
    } else if (index == 1) {
      return HomeScreen(isChecked: isChecked);
    } else if (index == 2) {
      return ClothScreen(isChecked: isChecked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isChecked ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black54,
          backgroundColor: Colors.lightBlueAccent,
          title: const Text(
            'Mezon Turkey',
            style: TextStyle(color: Colors.black54),
          ),
        ),
        endDrawer: CustomDrawer(
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
          value: isChecked,
        ),
        bottomNavigationBar: CustomNavigationBar(
          selectedIndex: selectedIndex,
          onItemTapped: onItemTapped,
        ),
        body: _screenOptions(selectedIndex), //_screenOptions(selectedIndex),
      ),
    );
  }
}
