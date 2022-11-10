import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/Screens/Sign/signIn.dart';

import '../DataContoller/todo.dart';

class FirebaseManager {
  //normal read
  FirebaseFirestore? _firebaseStorage;

  FirebaseManager() {
    _firebaseStorage = FirebaseFirestore.instance;
  }

  int pagLength = 9;
  int lengthOfData = 0;
  Future<List<Todo>> readData(bool reload) async {
    List<Todo> list = [];
    if (reload) {
      lengthOfData = 0;
    }

    await _firebaseStorage!
        .collection("todolist")
        .doc(auth.currentUs().toString())
        .collection("todos")
        .where("status", isEqualTo: true)
        //.orderBy("create-date", descending: true)
        .get()
        .then((value) {
      //fetch data by page length
      for (int i = 0; lengthOfData < value.size && i < pagLength; i++) {
        QueryDocumentSnapshot map = value.docs.elementAt(lengthOfData);
        //
        Todo todo = Todo(
          id: map.id,
          name: map['name'],
          addDate: DateTime.fromMillisecondsSinceEpoch(
              map["create-date"].millisecondsSinceEpoch),
          description: map['description'],
          todoDone: map['done'],
          dueDate: DateTime.fromMillisecondsSinceEpoch(
              map["duedate"].millisecondsSinceEpoch),
        );
        //
        lengthOfData++;
        list.add(todo);
      }
    });
    return list;
  }

  void addTodo(Todo todo) {
    Map<String, dynamic> m = {
      "name": todo.name,
      "description": todo.description,
      "duedate": todo.dueDate,
      "create-date": Timestamp.now(),
      "done": false,
      "status": true,
    };
    _firebaseStorage!
        .collection("todolist")
        .doc(auth.currentUs().toString())
        .collection("todos")
        .add(m);
  }

//delete db
  void deleteTodo(Todo todo) {
    _firebaseStorage!
        .collection("todolist")
        .doc(auth.currentUs())
        .collection("todos")
        .doc(todo.id)
        .update({"status": false});
  }

//update
  void updateTodo(Todo todo) {
    _firebaseStorage!
        .collection("todolist")
        .doc(auth.currentUs())
        .collection("todos")
        .doc(todo.id)
        .update({
      "name": todo.name,
      "description": todo.description,
      "done": false,
    });
  }

//
  void changeToggle(Todo todo) {
    _firebaseStorage!
        .collection("todolist")
        .doc(auth.currentUs())
        .collection("todos")
        .doc(todo.id)
        .update({"done": todo.todoDone});
  }
}
