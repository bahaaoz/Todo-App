import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todo_app/FirebaseManager/firebaseAuthentication.dart';
import 'package:todo_app/Localeization&&Theme/themeController.dart';
import 'package:todo_app/Screens/firstScreen.dart';

import '../../SupabaseManager/supabaseAuthentication.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  /// SupabaseAuth auth = SupabaseAuth();
  bool loading = false;
  FirebaseAuthentication auth = FirebaseAuthentication();
  ThemeController themeController = ThemeController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool errorPassword = false;
  String resultSignIn = "";
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width > 500 ? 500 : 300,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(
                flex: 1,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  fillColor: themeController.themeToggle
                      ? const Color.fromARGB(255, 0, 3, 29)
                      : Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: themeController.themeToggle
                            ? const Color.fromARGB(255, 0, 3, 29)
                            : Colors.white,
                        width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: themeController.themeToggle
                            ? const Color.fromARGB(255, 0, 3, 29)
                            : Colors.white,
                        width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: themeController.themeToggle
                            ? const Color.fromARGB(255, 0, 3, 29)
                            : Colors.white,
                        width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.email),
                  label: Text(
                    "Email".tr,
                    style: TextStyle(
                      color: !themeController.themeToggle
                          ? const Color.fromARGB(255, 0, 3, 29)
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                controller: passwordController,
                decoration: InputDecoration(
                  fillColor: themeController.themeToggle
                      ? const Color.fromARGB(255, 0, 3, 29)
                      : Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: themeController.themeToggle
                            ? const Color.fromARGB(255, 0, 3, 29)
                            : Colors.white,
                        width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  labelStyle: TextStyle(
                    color: !themeController.themeToggle
                        ? const Color.fromARGB(255, 0, 3, 29)
                        : Colors.white,
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  label: Text(
                    "Password".tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              errorPassword
                  ? Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        "The password is not the same".tr,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () async {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          !emailController.text.isEmail ||
                          !emailController.text.isEmail) {
                        return;
                      }
                      setState(() {
                        loading = true;
                      });
                      bool check = await auth.signIn(
                          emailController.text, passwordController.text);

                      if (check) {
                        setState(() {
                          loading = false;
                        });
                        Get.off(
                          const FirstScreen(),
                        );
                      } else {
                        setState(() {
                          loading = false;
                          resultSignIn = "Email or Password wrong";
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 60),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red,
                            blurRadius: 50,
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.red,
                            Colors.red,
                            Color.fromARGB(255, 255, 187, 0),
                          ],
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        "LOGIN".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: !themeController.themeToggle
                              ? const Color.fromARGB(255, 0, 3, 29)
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    resultSignIn,
                    style: TextStyle(
                      color: !themeController.themeToggle
                          ? const Color.fromARGB(255, 0, 3, 29)
                          : Colors.white,
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
