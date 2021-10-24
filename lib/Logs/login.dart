import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mezon_turkey/screens/login_screen.dart';
import 'package:mezon_turkey/screens/register_screen.dart';

class LogIn extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future emailLogIn(String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text(
                'ایمیل وارد شده وجود ندارد',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('باشه'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Register.id);
                  },
                  child: const Text('ثبت نام'),
                ),
              ],
            );
          },
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text(
                'پسورد وارد شده برای ایمیل صحیح نمی باشد',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('باشه'),
                ),
                TextButton(
                  onPressed: () {
                    //TODO: implement forgot password
                  },
                  child: const Text('فاموشی رمز'),
                ),
              ],
            );
          },
        );
      }
    }
    notifyListeners();
  }

  Future register(String email, String password, BuildContext context) async {
    if (password.length < 6) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('پسورد حداقل باید ۶ کاراکتر باشد'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('باشه'),
              ),
            ],
          );
        },
      );
    }
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text('پسورد ضعیف است'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('باشه'),
              )
            ],
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text('ایمیل قبلا ثبت شده است'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('باشه'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginFlow.id);
                },
                child: const Text('ورود'),
              ),
            ],
          ),
        );
      }
    }
    notifyListeners();
  }
}
