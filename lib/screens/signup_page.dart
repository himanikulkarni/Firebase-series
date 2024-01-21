import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_series/widgets/customs.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signUp(String email, String password) async {
    if (email == "" && password == "") {
      widgets.CustomAlertBox(context, "Enter required fields");
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyHomePage(
                        title: "HomePage",
                      )));
          return null;
        });
      } on FirebaseAuthException catch (ex) {
        return widgets.CustomAlertBox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Page'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widgets.CustomTextfield(emailController, "Email", Icons.mail, false),
          widgets.CustomTextfield(
              passwordController, "Password", Icons.password, true),
          const SizedBox(
            height: 30,
          ),
          widgets.CustomButton(() {
            signUp(emailController.text.toString(),
                passwordController.text.toString());
          }, "Sign Up"),
        ],
      ),
    );
  }
}
