 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/DataContoller/dataController.dart';
import 'package:todo_app/Screens/edit.dart';
 import 'package:todo_app/Screens/searchForm.dart';
import 'package:todo_app/SqlfLite/sqLite.dart';
import 'package:todo_app/Widgets/card.dart';

import '../DataContoller/todo.dart';

//final keyList = GlobalKey<AnimatedListState>();

class DisplayList extends StatefulWidget {
  const DisplayList({Key? key}) : super(key: key);

  @override
  State<DisplayList> createState() => _DisplayListState();
}

class _DisplayListState extends State<DisplayList> {
  ScrollController scrollController = ScrollController();
  SqlLite localdb = SqlLite();
  DataController controller = Get.find();
  @override
  void initState() {
    super.initState();

    loading();
    skletonHide();
  }

  bool skletonPage = true;
  Future<void> skletonHide() async {
    await controller.loadControl("", true);

    skletonPage = false;
  }

  bool twoSlot = true;
  void loading() {
    scrollController.addListener(() async {
      twoSlot = false;
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        await controller.loadControl(lastSearch, false);
        twoSlot = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataController>(
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            setState(() {
              //controller.getList.clear();
              skletonPage = true;
            });

            await controller.loadControl(lastSearch, true);
            skletonPage = false;
          },
          child: skletonPage
              ? ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return skelton();
                  },
                )
              : ListView.builder(
                  controller: scrollController,
                  itemCount: controller.size + 2,
                  itemBuilder: (context, index) {
                    if (index < controller.size) {
                      return ListCard(
                        todo: controller.getList[index],
                        onClickDelete: () {
                          removeMethod(index, controller);
                          Navigator.pop(context);
                        },
                        onClickEdit: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.width,
                                child: Dialog(
                                  child: Center(
                                      child: Edit(
                                    todo: controller.getList[index],
                                  )),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else if (!twoSlot) {
                      return skelton();
                    } else {
                      return Container();
                    }
                  },
                ),
        );
      },
    );
  }

  Container skelton() {
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
        leading: skeltonContaner(30, 30),
        title: skeltonContaner(40, 10),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            skeltonContaner(200, 8),
            skeltonContaner(150, 8),
            skeltonContaner(170, 8),
          ],
        ),
        trailing: skeltonContaner(50, 18),
      ),
    );
  }

  Container skeltonContaner(double width, double height) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: Color.fromARGB(123, 154, 154, 154),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  void removeMethod(int index, DataController controller) {
    Todo removedTodo = controller.getList[index];
    controller.removeTodo(removedTodo);

    // keyList.currentState?.removeItem(
    //   index,
    //   (context, animation) => ListCard(
    //     todo: removedTodo,
    //     onClickDelete: () {},
    //     onClickEdit: () {},
    //   ),
    //   duration: const Duration(milliseconds: 600),
    // );
  }
}
