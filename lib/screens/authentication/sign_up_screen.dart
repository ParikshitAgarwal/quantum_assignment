import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpScreen extends StatefulWidget {
  final signUpdataFunc;

  SignUpScreen({
    Key? key,
    required this.signUpdataFunc,
  }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isTicked = false;
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController numEditingController = TextEditingController();
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
                "Create an Account",
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
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
            textInputFieldFunc(nameEditingController, "John doe",
                Icons.account_circle_outlined, (value) {
              if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                return "Enter correct name";
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
                  "Contact no.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
            // Container(
            //     margin: const EdgeInsets.symmetric(horizontal: 40),
            //     child: TextFormField(
            //       // keyboardType: inputType,
            //       validator: (value) {
            //         if (value!.isEmpty ||
            //             !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
            //           return "Enter correct name";
            //         } else {
            //           return null;
            //         }
            //       },
            //       // obscureText: obscureText,
            //       controller: numEditingController,
            //       onChanged: (v) {
            //         widget.signUpdataFunc(
            //             nameEditingController.text,
            //             emailEditingController.text,
            //             passwordEditingController.text,
            //             numEditingController.text,
            //             formKey.currentState);
            //       },
            //       decoration: InputDecoration(
            //           suffixIcon: Icon(
            //             Icons.call,
            //           ),
            //           suffixIconColor: Colors.red,
            //           hintText: "9876543210",
            //           hintStyle: TextStyle(color: Colors.grey, fontSize: 20)),
            //     )),
            textInputFieldFunc(numEditingController, "9876543210", Icons.call,
                inputType: TextInputType.number, (value) {
              if (value!.isEmpty || !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                return "Enter correct number";
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
                passwordEditingController, "**********", Icons.lock, (value) {
              if (value != null && value.length < 7) {
                return "Enter min. 7 characters";
              } else {
                return null;
              }
            }, obscureText: true),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: isTicked,
                  onChanged: (bool? value) {
                    setState(() {
                      isTicked = value;
                    });
                  },
                ),
                const Text("I agree with", style: TextStyle(fontSize: 20)),
                TextButton(
                    onPressed: () {},
                    child: const Text("terms & condition",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an Account?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black45),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Sign In!",
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
      {bool obscureText = false, TextInputType? inputType}) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        child: TextFormField(
          keyboardType: inputType,
          validator: (value) {
            return validator(value);
          },
          obscureText: obscureText,
          controller: controller,
          onChanged: (v) {
            widget.signUpdataFunc(
                nameEditingController.text,
                emailEditingController.text,
                passwordEditingController.text,
                numEditingController.text,
                formKey.currentState);
          },
          decoration: InputDecoration(
              suffixIcon: Icon(
                icon,
              ),
              suffixIconColor: Colors.red,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 20)),
        ));
  }
}
