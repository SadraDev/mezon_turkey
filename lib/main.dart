import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mezon_turkey/admin/admin_screen.dart';
import 'package:mezon_turkey/screens/login_screen.dart';
import 'package:mezon_turkey/screens/main_screen.dart';
import 'package:mezon_turkey/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MezonTurkey());
}

class MezonTurkey extends StatefulWidget {
  const MezonTurkey({Key? key}) : super(key: key);

  @override
  _MezonTurkeyState createState() => _MezonTurkeyState();
}

class _MezonTurkeyState extends State<MezonTurkey> {
  bool theme = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginFlow.id,
      routes: {
        MainScreen.id: (context) => const MainScreen(),
        AdminScreen.id: (context) => const AdminScreen(),
        LoginFlow.id: (context) => const LoginFlow(),
        Register.id: (context) => const Register(),
      },
    );
  }
}
