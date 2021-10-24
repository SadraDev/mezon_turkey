import 'package:mezon_turkey/screens/login_screen.dart';
import 'package:mezon_turkey/Logs/login.dart';
import 'package:validators/validators.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static const String id = 'register_screen';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  bool obscure = true;
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    color: Colors.blue,
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(),
                flex: 3,
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 550,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 5,
                      color: Colors.black26,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Text(
                        'REGISTER',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w900,
                          fontSize: 36,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'JohnDoe@example.io',
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.lightBlueAccent, width: 2),
                            ),
                            labelText: 'Email',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.grey),
                            floatingLabelStyle:
                                TextStyle(color: Colors.lightBlueAccent),
                          ),
                          validator: (email) => !isEmail(email!)
                              ? 'لطفا ایمیل را صحیح وارد کنید '
                              : null,
                          onChanged: (value) {
                            _email = value;
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextField(
                              obscureText: obscure,
                              decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlueAccent, width: 2),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() => obscure = !obscure);
                                  },
                                  icon: Icon(
                                    obscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                labelText: 'Password',
                                labelStyle: const TextStyle(
                                    fontSize: 16, color: Colors.grey),
                                floatingLabelStyle: const TextStyle(
                                    color: Colors.lightBlueAccent),
                              ),
                              onChanged: (value) {
                                _password = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        child: Container(
                          child: const Text(
                            'REGISTER',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 55, vertical: 20),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Colors.blue,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff1565C0),
                                Colors.lightBlue,
                                Colors.lightBlueAccent,
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          final provider =
                              Provider.of<LogIn>(context, listen: false);

                          if (formKey.currentState!.validate()) {
                            provider.register(_email!, _password!, context);
                          }
                        },
                      ),
                      GestureDetector(
                        child: const Text(
                          'Already have an account? log in',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        onTap: () {
                          Navigator.popAndPushNamed(context, LoginFlow.id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
