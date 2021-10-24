// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mezon_turkey/screens/register_screen.dart';
import 'main_screen.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class LoginFlow extends StatefulWidget {
  const LoginFlow({Key? key}) : super(key: key);
  static const String id = 'login_flow_screen';

  @override
  _LoginFlowState createState() => _LoginFlowState();
}

class _LoginFlowState extends State<LoginFlow> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.lightBlueAccent),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong!'),
          );
        } else if (snapshot.hasData) {
          return const MainScreen();
        } else {
          return const Login();
        }
      },
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                  decoration: BoxDecoration(
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 550,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 5,
                      color: Colors.black26,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w900,
                        fontSize: 36,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextField(
                        decoration: InputDecoration(
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
                        onChanged: (value) {
                          _email = value;
                        },
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: TextField(
                            obscureText: obscure,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
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
                              labelStyle:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                              floatingLabelStyle:
                                  TextStyle(color: Colors.lightBlueAccent),
                            ),
                            onChanged: (value) {
                              _password = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 25, top: 10),
                          child: GestureDetector(
                            child: Text(
                              'Forgot your password',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Container(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 55, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.blue,
                          gradient: LinearGradient(
                            colors: const [
                              Color(0xff1565C0),
                              Colors.lightBlue,
                              Colors.lightBlueAccent,
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        try {
                          _auth.signInWithEmailAndPassword(
                            email: _email!,
                            password: _password!,
                          );
                        } on FirebaseAuthException {
                          //TODO: show custom alert
                        }
                      },
                    ),
                    GestureDetector(
                      child: Text(
                        'Don\'t have an account? Sign up',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Register.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
