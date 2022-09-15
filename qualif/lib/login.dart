import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qualif/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void handleLogin() {
    String email = emailController.text;
    String pass = passController.text;
    String dialog = '';
    if (email == '' || pass == '') {
      dialog = "All fields should be filled";
    } else if (!email.contains('@')) {
      dialog = "Email should contain @";
    } else if (!email.endsWith('.com')) {
      dialog = "Email should ends with .com";
    } else if (pass.length < 6) {
      dialog = "Password should be >=6 characters";
    }

    if (dialog != '') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(dialog),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          );
        },
      );
      return;
    }

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return HomePage(email: emailController.text);
      },
    ), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gopud'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: Image.asset(
                  'assets/logo.png',
                  height: 100,
                  width: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextField(
                  obscureText: true,
                  controller: passController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              ElevatedButton(onPressed: handleLogin, child: const Text("Sign in"))
            ],
          ),
        ),
      ),
    );
  }
}
