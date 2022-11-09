import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quantum_assignment/screens/authentication/sign_in_screen.dart';
import 'package:quantum_assignment/screens/authentication/sign_up_screen.dart';
import 'package:quantum_assignment/services/firebase_auth_methods.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int tabBarIndex = 0;
  bool isTicked = false;
  String name = "";
  String email = "";
  String password = "";
  String phoneNum = "";
  FormState formState = FormState();
  void signIndataRetriveFunc(
      String email, String password, FormState formState) {
    this.email = email;
    this.password = password;
    this.formState = formState;
  }

  void signUpdataRetriveFunc(String name, String email, String password,
      String phoneNum, FormState formState, bool isTicked) {
    this.name = name;
    this.email = email;
    this.password = password;
    this.phoneNum = phoneNum;
    this.formState = formState;
    this.isTicked = isTicked;
  }

  void signUpUser() async {
    FirebaseAuthMethods(FirebaseAuth.instance)
        .signUpWithEmail(email: email, password: password, context: context);
  }

  void signInUser() async {
    FirebaseAuthMethods(FirebaseAuth.instance)
        .loginWithEmail(email: email, password: password, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "SocialX",
            style: TextStyle(fontSize: 24),
          ),
          bottom: TabBar(
              onTap: (int index) {
                setState(() {});
                tabBarIndex = index;
                print(tabBarIndex);
              },
              tabs: const [
                Tab(
                  text: 'LOGIN',
                ),
                Tab(
                  text: 'SIGN UP',
                )
              ]),
        ),
        body: TabBarView(children: [
          SignInScreen(signIndataFunc: signIndataRetriveFunc),
          SignUpScreen(signUpdataFunc: signUpdataRetriveFunc)
        ]),
        bottomNavigationBar: InkWell(
          onTap: () {
            // formState.validate();

            tabBarIndex == 0
                ? signInUser()
                : isTicked
                    ? signUpUser()
                    : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Please accept terms & condition to move ahead")));
            // formState.reset();
          },
          child: Material(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            color: Colors.red,
            child: SizedBox(
                height: kToolbarHeight,
                width: double.infinity,
                child: Center(
                  child: Text(
                    tabBarIndex == 0 ? "LOGIN" : "REGISTER",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
