import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/DataContoller/todo.dart';
import 'package:todo_app/SupabaseManager/supabaseManager.dart';

class DataController extends GetxController {
  SupabaseManager? _supabaseManager;
  List<Todo>? _todoList;
  int get size => _todoList!.length;
  List<Todo> get getList => _todoList!;

  DataController() {
    _supabaseManager = SupabaseManager();
    _todoList = [];
  }
//load data _____________________________________
  String _lastSearchText = "";
  int _from = 0;
  loadControl(String searchText, bool reload) async {
    if (_lastSearchText != searchText || reload) {
      _lastSearchText =  searchText;
      _todoList!.clear();
      _from = 0;
    }

    if (searchText == "" ) {
      await _loadData(_from);
    } else {
      await _loadDataSearch(_from, searchText);
    }

    update();
  }

  _loadData(int from) async {
    List<Todo> list = await _supabaseManager!.readData(from);
    _todoList!.addAll(list);
    _from += list.length;
  }

  _loadDataSearch(int from, String textSearch) async {
    List<Todo> list = await _supabaseManager!.readDataSearch(from, textSearch);

    _todoList!.addAll(list);
    _from += list.length;
  }

  //.............................................

  //remove todo _______________________________
  void removeTodo(Todo todo) {
    _todoList?.remove(todo);

    _supabaseManager?.deleteTodo(todo.id!);
    update();
  }
  //.........................................\

//add todo ___________________________________
  void addTodo(Todo todo) {
    _supabaseManager?.addTodo(todo);
    update();
  }
  //..........................................

//update todo ___________________________________
  void updateTodo(Todo todo) {
    _supabaseManager?.updateTodo(todo);
    update();
  }
  //..........................................

//change toggle __________________________

  void changeToggle(Todo todo) {
    todo.todoDone = !todo.todoDone!;
    _supabaseManager!.changeToggle(todo);
  }
}
