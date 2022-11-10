import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo_app/DataContoller/todo.dart';
import 'package:todo_app/FirebaseManager/firebaseAuthentication.dart';
import 'package:todo_app/FirebaseManager/firebaseManager.dart';

class DataController extends GetxController {
  FirebaseManager? _firebaseManager;
  FirebaseAuthentication? _firebaseAuth;
  List<Todo>? _todoList;
  int get size => _todoList!.length;
  List<Todo> get getList => _todoList!;

  DataController() {
    _firebaseManager = FirebaseManager();
    _firebaseAuth = FirebaseAuthentication();
    _todoList = [];
  }
//load data _____________________________________
  String _lastSearchText = "";
  bool _reload = false; // true : load && false : read first time

  Future<void> loadControl(String searchText, bool reload) async {
    if (_lastSearchText != searchText || reload) {
      _lastSearchText = searchText;
      _todoList!.clear();
      _reload = true;
    }
    await _loadData();
    update();
  }

  _loadData() async {
    List<Todo> list = [];
    list = await _firebaseManager!.readData(_reload);
    _reload = false;
    _todoList!.addAll(list);
  }

  //remove todo _______________________________
  void removeTodo(Todo todo) {
    _todoList?.remove(todo);
    _firebaseManager!.deleteTodo(todo);
    update();
  }
  //.........................................\

//add todo ___________________________________
  void addTodo(Todo todo) {
    _firebaseManager?.addTodo(todo);
    update();
  }
  //..........................................

//update todo ___________________________________
  void updateTodo(Todo todo) {
    _firebaseManager!.updateTodo(todo);
    update();
  }
  //..........................................

//change toggle __________________________

  void changeToggle(Todo todo) {
    todo.todoDone = !todo.todoDone!;
    _firebaseManager!.changeToggle(todo);
  }

  bool get isAnonymous {
    return _firebaseAuth!.isAnonymous;
  }
}
