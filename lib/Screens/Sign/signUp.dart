import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todo_app/FirebaseManager/firebaseAuthentication.dart';
import 'package:todo_app/SupabaseManager/supabaseAuthentication.dart';

import '../../Localeization&&Theme/themeController.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //SupabaseAuth auth = SupabaseAuth();
  FirebaseAuthentication auth = FirebaseAuthentication();
  ThemeController themeController = ThemeController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  String resultSignUp = "";
  bool errorPassword = false;
  bool hud = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: const Color.fromARGB(69, 0, 0, 0),
      inAsyncCall: hud,
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
                  labelStyle: TextStyle(
                    color: !themeController.themeToggle
                        ? const Color.fromARGB(255, 0, 3, 29)
                        : Colors.white,
                  ),
                  prefixIcon: const Icon(Icons.email),
                  label: Text(
                    "Email".tr,
                    style: const TextStyle(
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
                  prefixIcon: const Icon(Icons.lock),
                  label: Text(
                    "Password".tr,
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
                controller: rePasswordController,
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
                  labelStyle: TextStyle(
                    color: !themeController.themeToggle
                        ? const Color.fromARGB(255, 0, 3, 29)
                        : Colors.white,
                  ),
                  prefixIcon: Icon(Icons.lock),
                  label: Text(
                    "Confirmation Password".tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
                      if (!emailController.text.isEmail) {
                        setState(() {
                          resultSignUp = "wroing email";
                        });
                        return;
                      }
                      if (passwordController.text !=
                          rePasswordController.text) {
                        setState(() {
                          errorPassword = true;
                        });
                      } else {
                        setState(() {
                          hud = true;
                        });
                        String str = await auth.signUp(
                            emailController.text, passwordController.text);
                        setState(() {
                          emailController.clear();
                          passwordController.clear();
                          rePasswordController.clear();
                          hud = false;
                          errorPassword = false;
                          resultSignUp = str;
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
                        "SignUp".tr,
                        style: TextStyle(
                          color: !themeController.themeToggle
                              ? const Color.fromARGB(255, 0, 3, 29)
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      textAlign: TextAlign.center,
                      resultSignUp,
                      style: TextStyle(
                        color: !themeController.themeToggle
                            ? const Color.fromARGB(255, 0, 3, 29)
                            : Colors.white,
                      ),
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
