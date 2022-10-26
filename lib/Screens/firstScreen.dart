import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Localeization&&Theme/themeController.dart';
import 'package:todo_app/Localeization&&Theme/myLocale.dart';
import 'package:todo_app/Localeization&&Theme/myLocaleController.dart';
import 'package:todo_app/Screens/add.dart';
import 'package:todo_app/Screens/displayList.dart';
import 'package:todo_app/Screens/searchForm.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);
  //final void Function(Locale local) setLocale;
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
  }
 
  @override
  Widget build(BuildContext context) {
    MyLocaleController getController = Get.find();
    return Scaffold(
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
      appBar: AppBar(
        leading: DropdownButton(
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
            Get.snackbar("Change Languge".tr, "Language has changed".tr);
          },
        ),
        actions: [
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
          )
        ],
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
    );
  }
}
