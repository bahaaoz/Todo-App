import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/DataContoller/dataController.dart';

import '../Localeization&&Theme/themeController.dart';
import '../DataContoller/todo.dart';

class ListCard extends StatefulWidget {
  final Todo? todo;
  final VoidCallback? onClickEdit;
  final VoidCallback? onClickDelete;

  ListCard({
    required this.todo,
    required this.onClickEdit,
    required this.onClickDelete,
    Key? key,
  }) : super(key: key);

  @override
  State<ListCard> createState() => _listCardState();
}

class _listCardState extends State<ListCard> {
  DataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: ListTile(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 100,
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: widget.onClickEdit,
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                            onPressed: widget.onClickDelete,
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  );
                },
                
              );
            },
            icon: const Icon(
              Icons.list,
              color: Colors.blue,
            ),
          ),
          title: Text(
            widget.todo!.name.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.todo!.description.toString(),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 5,
                ),
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Text(
                  widget.todo!.dueDate.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          trailing: Column(
            children: [
              Switch(
                value: widget.todo!.todoDone ?? false,
                onChanged: (value) {
                  setState(() {
                    controller.changeToggle(widget.todo!);
                  });
                },
              ),
            ],
          )),
    );
  }
}
