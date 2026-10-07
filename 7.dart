import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool remember = false;

  @override
  void initState() {
    super.initState();
    loadRemember();
  }

  Future<void> loadRemember() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      remember = prefs.getBool('remember') ?? false;
    });
  }

  Future<void> saveRemember(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      remember = value;
    });

    await prefs.setBool('remember', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Username',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          CheckboxListTile(
            title: Text('Remember Me'),
            value: remember,
            onChanged: (value) {
              saveRemember(value!);
            },
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}