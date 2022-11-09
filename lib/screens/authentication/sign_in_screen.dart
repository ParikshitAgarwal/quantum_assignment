import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quantum_assignment/services/firebase_auth_methods.dart';

class SignInScreen extends StatelessWidget {
  final signIndataFunc;
  SignInScreen({
    Key? key,
    required this.signIndataFunc,
  }) : super(key: key);

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              width: 230,
              margin: const EdgeInsets.only(left: 40),
              child: const Text(
                "SignIn into your Account",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                margin: const EdgeInsets.only(left: 40),
                child: const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
            textInputFieldFunc(
                emailEditingController, "johndoe@gmail.com", Icons.email,
                (value) {
              if (value!.isEmpty ||
                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                return "Enter a valid email";
              } else {
                return null;
              }
            }),
            const SizedBox(
              height: 20,
            ),
            Container(
                margin: const EdgeInsets.only(left: 40),
                child: const Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
            textInputFieldFunc(
                passwordEditingController, "Password", Icons.lock,
                obscureText: true, (value) {
              if (value != null && value.length < 7) {
                return "Enter min. 7 characters";
              } else {
                return null;
              }
            }),
            Container(
              margin: const EdgeInsets.only(right: 30),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password ?",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
                child: Text(
              "Login with",
              style: TextStyle(fontSize: 18),
            )),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black45)),
                  child: InkWell(
                    onTap: () {
                      FirebaseAuthMethods(FirebaseAuth.instance)
                          .signInWithGoogle(context);
                    },
                    child: Image.asset(
                      "assets/images/google_logo.png",
                      height: 40,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Image.asset(
                  "assets/images/fb_logo.png",
                  height: 65,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an Account?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black45),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Register Now",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Container textInputFieldFunc(TextEditingController controller,
      String hintText, IconData icon, Function validator,
      {bool obscureText = false}) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        child: TextFormField(
          validator: (value) {
            return validator(value);
          },
          obscureText: obscureText,
          controller: controller,
          onChanged: (v) {
            signIndataFunc(emailEditingController.text,
                passwordEditingController.text, formKey.currentState);
          },
          decoration: InputDecoration(
              suffixIcon: Icon(
                icon,
              ),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 20)),
        ));
  }
}
