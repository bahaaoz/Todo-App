import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/Screens/Sign/signIn.dart';
import 'package:todo_app/Screens/Sign/signUp.dart';
import 'package:todo_app/Screens/firstScreen.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("................................................................");
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                TabBar(
                  isScrollable: true,
                  controller: tabController,
                  tabs: [
                    Tab(
                      child: Text(
                        "SignIn".tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "SignUp".tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
                MaterialButton(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Text(
                      "Back".tr,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  SignIn(),
                  SignUp(),
                ],
              ),
            ),
            const Text(
              "Forget password!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
      // child: Column(children: [
      //   const SizedBox(
      //     height: 20,
      //   ),
      //   Row(
      //     children: [
      //       MaterialButton(

      //         child: const Text(
      //           "SignIn",
      //           style: TextStyle(),
      //         ),
      //         onPressed: () {},
      //       ),
      //       MaterialButton(
      //         child: const Text(
      //           "SignUp",
      //           style: TextStyle(),
      //         ),
      //         onPressed: () {},
      //       )
      //     ],
      //   )
      // ]),
    );
  }
}
