import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/DataContoller/todo.dart';
import 'package:todo_app/FirebaseManager/firebaseManager.dart';
import 'package:todo_app/SupabaseManager/supabaseManager.dart';

class DataController extends GetxController {
  //SupabaseManager? _supabaseManager;
  FirebaseManager? _firebaseManager;
  List<Todo>? _todoList;
  int get size => _todoList!.length;
  List<Todo> get getList => _todoList!;

  DataController() {
    //_supabaseManager = SupabaseManager();
    _firebaseManager = FirebaseManager();
    _todoList = [];
  }
//load data _____________________________________
  String _lastSearchText = "";
  int _from = 0;
  int _lastForm = 0;
  Future<bool> loadControl(String searchText, bool reload) async {
    if (_lastSearchText != searchText || reload) {
      _lastSearchText = searchText;
      _todoList!.clear();
      _from = 0;
    }
    _lastForm = _from;
    if (searchText == "") {
      await _loadData(_from);
    } else {
      await _loadDataSearch(_from, searchText);
    }

    update();
    if (_lastForm == _from) {
      return false;
    }
    return true;
  }

  _loadData(int from) async {
    //List<Todo> list = await _supabaseManager!.readData(from);
    List<Todo> list = await _firebaseManager!.readData(from);
    _todoList!.clear();
    _todoList!.addAll(list);
    _from += list.length;
    print("...............................");

    print(list.length);
    print("...............................");
  }

  _loadDataSearch(int from, String textSearch) async {
    //List<Todo> list = await _supabaseManager!.readDataSearch(from, textSearch);
    List<Todo> list = await _firebaseManager!.readDataSearch(from, textSearch);
    _todoList!.clear();
    _todoList!.addAll(list);
    _from += list.length;
  }

  //.............................................

  //remove todo _______________________________
  void removeTodo(Todo todo) {
    _todoList?.remove(todo);
    _firebaseManager!.deleteTodo(todo);
    // _supabaseManager?.deleteTodo(todo.id!);
    update();
  }
  //.........................................\

//add todo ___________________________________
  void addTodo(Todo todo) {
    _todoList!.add(todo);
    // _supabaseManager?.addTodo(todo);
    _firebaseManager?.addTodo(todo);
    update();
  }
  //..........................................

//update todo ___________________________________
  void updateTodo(Todo todo) {
    // _supabaseManager?.updateTodo(todo);
    _firebaseManager!.updateTodo(todo);
    update();
  }
  //..........................................

//change toggle __________________________

  void changeToggle(Todo todo) {
    todo.todoDone = !todo.todoDone!;
    // _supabaseManager!.changeToggle(todo);
    _firebaseManager!.changeToggle(todo);
  }
}
