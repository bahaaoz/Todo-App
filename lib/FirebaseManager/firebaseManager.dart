import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/Screens/searchForm.dart';
import 'package:todo_app/main.dart';

import '../DataContoller/todo.dart';

FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;

class FirebaseManager {
  //normal read
  Future<List<Todo>> readData(int from) async {
    final response = await _firebaseStorage
        .collection("todo-list")
        .limit(from + 9)
        .orderBy("create-date")
        .get();
    List<Todo> list = [];

    for (var x in response.docs) {
      if (userUID == x.get("user-add") && x.get("status") == true) {
        Todo todo = Todo(
          id: x.id,
          name: x.get("name"),
          addDate: DateTime.fromMillisecondsSinceEpoch(
              x.get("create-date").millisecondsSinceEpoch),
          description: x.get("description"),
          todoDone: x.get("done"),
          dueDate: DateTime.fromMillisecondsSinceEpoch(
              x.get("duedate").millisecondsSinceEpoch),
        );
        list.add(todo);
      }
    }

    return list;
  }

//search read data

  Future<List<Todo>> readDataSearch(int from, String str) async {
    final response = await _firebaseStorage
        .collection("todo-list")
        .limit(from + 9)
        .orderBy("create-date")
        .get();
    List<Todo> list = [];
    for (var x in response.docs) {
      if (userUID == x.get("user-add") && x.get("status") == true) {
        Todo todo = Todo(
          id: x.id,
          name: x.get("name"),
          addDate: DateTime.fromMillisecondsSinceEpoch(
              x.get("create-date").millisecondsSinceEpoch),
          description: x.get("description"),
          todoDone: x.get("done"),
          dueDate: DateTime.fromMillisecondsSinceEpoch(
              x.get("duedate").millisecondsSinceEpoch),
        );
        list.add(todo);
      }
    }

    return list;
  }

  ///add data db

  void addTodo(Todo todo) {
    _firebaseStorage.collection("todo-list").add({
      "name": todo.name,
      "description": todo.description,
      "duedate": todo.dueDate,
      "create-date": Timestamp.now(),
      "done": false,
      "status": true,
      "user-add": userUID,
    });
  }

//delete db
  void deleteTodo(Todo todo) {
    _firebaseStorage.collection("todo-list").doc(todo.id).update({
      "status": false,
    });
  }

//update
  void updateTodo(Todo todo) {
    _firebaseStorage.collection("todo-list").doc(todo.id).update({
      "name": todo.name,
      "description": todo.description,
      "done": false,
    });
  }

  void changeToggle(Todo todo) {
    _firebaseStorage
        .collection("todo-list")
        .doc(todo.id)
        .update({"done": todo.todoDone});
  }
}
