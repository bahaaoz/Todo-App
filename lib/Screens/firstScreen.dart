import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/FirebaseManager/firebaseAuthentication.dart';
import 'package:todo_app/Localeization&&Theme/themeController.dart';
import 'package:todo_app/Localeization&&Theme/myLocale.dart';
import 'package:todo_app/Localeization&&Theme/myLocaleController.dart';
import 'package:todo_app/Screens/Sign/signIn.dart';
import 'package:todo_app/Screens/Sign/signPage.dart';
import 'package:todo_app/Screens/add.dart';
import 'package:todo_app/Screens/displayList.dart';
import 'package:todo_app/Screens/searchForm.dart';

import '../DataContoller/dataController.dart';

FirebaseAuthentication _firebaseAuthentication = FirebaseAuthentication();

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);
  //final void Function(Locale local) setLocale;
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    MyLocaleController getController = Get.find();
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.width,
                  child: Dialog(
                    child: Center(child: Add()),
                  ),
                );
              },
            );
          },
        ),
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  color: Colors.black45,
                  width: double.infinity,
                  height: 150,
                  child: Stack(children: [
                    GetBuilder<DataController>(
                      builder: (controller) {
                        return auth.isAnonymous
                            ? Container()
                            : Positioned(
                                top: 50,
                                left: 20,
                                child: Text(auth.email()),
                              );
                      },
                    ),
                    Positioned(
                      right: 5,
                      top: 30,
                      child: Column(
                        children: [
                          DropdownButton(
                            underline: Container(),
                            icon: const Icon(Icons.language),
                            items: MyLocal()
                                .keys
                                .keys
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              getController.changeLocale(value!);
                              Get.snackbar("Change Languge".tr,
                                  "Language has changed".tr);
                            },
                          ),
                          Consumer<ThemeController>(
                            builder: (context, controller, child) {
                              //  controller.getData(controller.searchText);
                              return Switch(
                                value: controller.themeToggle,
                                onChanged: (value) {
                                  controller.clickThemeToggle();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                GetBuilder<DataController>(
                  builder: (controller) {
                    return auth.isAnonymous
                        ? Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(
                                  30,
                                )),
                                border: Border.all(
                                  color: Colors.black87,
                                  width: 1.5,
                                )),
                            child: MaterialButton(
                              child: Text(
                                "SignIn".tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Get.to(const Sign());
                              },
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(
                                  30,
                                )),
                                border: Border.all(
                                  color: Colors.black87,
                                  width: 1.5,
                                )),
                            child: MaterialButton(
                              child: Text(
                                "LOGOUT".tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21,
                                ),
                              ),
                              onPressed: () async {
                                await _firebaseAuthentication.signout();
                                // Navigator.of(context).pop();
                              },
                            ),
                          );
                  },
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            "Todo App".tr,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 7,
          ),
          child: Column(
            children: [
              SearchForm(),
              const Expanded(
                child: DisplayList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
