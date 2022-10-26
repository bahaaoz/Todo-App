import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/DataContoller/dataController.dart';

String lastSearch = "";

class SearchForm extends StatelessWidget {
  SearchForm({Key? key}) : super(key: key);
  Timer? depounce;

  TextEditingController serchController = TextEditingController();
  DataController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextField(
          controller: serchController,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.clear,
              ),
            ),
            prefixIcon: const Icon(Icons.search),
            label: Text("search".tr),
            border: const OutlineInputBorder(),
          ),
          onChanged: (value) {
            if (value == ' ') {
              serchController.text = "";
              return;
            }
            if (depounce?.isActive ?? false) depounce?.cancel();
            depounce = Timer(
              const Duration(milliseconds: 300),
              () {
                if (lastSearch != serchController.text) {
                  lastSearch = value.trim();
                  controller.loadControl(lastSearch, false);
                }
              },
            );
          },
        ));
  }
}
