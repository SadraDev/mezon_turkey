import 'package:mezon_turkey/custom%20drawer%20screens/shopping_list.dart';
import 'package:mezon_turkey/admin/admin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

User? user = FirebaseAuth.instance.currentUser;

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    required this.onChanged,
    required this.value,
  }) : super(key: key);
  final void Function(bool?) onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text(
                  'Mezon Turkey',
                  style: TextStyle(
                    color: value ? Colors.lightBlueAccent : Colors.black87,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.messenger),
              onTap: () {},
              title: const Text('پیام به فروشنده'),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShoppingList(),
                  ),
                );
              },
              title: const Text('سبد خرید'),
            ),
            CheckboxListTile(
              value: value,
              activeColor: Colors.lightBlueAccent,
              checkColor: Colors.white,
              secondary: value
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode),
              onChanged: onChanged,
              title: const Text('حالت شب'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: const Text('آیا می خواهید از اکانت خارج شوید؟'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('نه'),
                      ),
                      TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        child: const Text('بله'),
                      ),
                    ],
                  ),
                );
              },
              title: const Text('خروج از اکانت شخصی'),
            ),
            const AdminOrNot(),
          ],
        ),
      ),
    );
  }
}

class AdminOrNot extends StatelessWidget {
  const AdminOrNot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user!.uid.toString() == 'ViDaBMnGY0dnI32oKXKk9QXgXCY2') {
      return ListTile(
        leading: const Icon(Icons.admin_panel_settings_rounded),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminScreen(),
            ),
          );
        },
        title: const Text('پنل ادمین'),
      );
    } else {
      return Container();
    }
  }
}
