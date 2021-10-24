import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar(
      {Key? key, required this.selectedIndex, required this.onItemTapped})
      : super(key: key);

  final int selectedIndex;
  final onItemTapped;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedIconTheme: const IconThemeData(color: Colors.lightBlueAccent),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.shoePrints,
          ),
          label: 'shoes',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.home,
          ),
          label: 'home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.tshirt,
          ),
          label: 'clothing',
        ),
      ],
    );
  }
}
