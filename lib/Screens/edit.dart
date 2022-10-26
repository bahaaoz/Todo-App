import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/DataContoller/dataController.dart';
import 'package:todo_app/DataContoller/todo.dart';

class Edit extends StatelessWidget {
  Todo? todo;
  Edit({
    required this.todo,
    Key? key,
  }) : super(key: key);
  DataController controller = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    nameController.text = todo!.name!;
    descriptionController.text = todo!.description!;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: "Todo Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: "Todo Description",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              "Due Date",
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text == "") {
                return;
              }

              todo!.name = nameController.text;
              todo!.description = descriptionController.text;
              //TODO
              controller.updateTodo(todo!);
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: Text("Edit"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
