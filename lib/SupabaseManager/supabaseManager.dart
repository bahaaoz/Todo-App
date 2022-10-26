import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../DataContoller/todo.dart';

class SupabaseManager {
  Future readData(int from) async {
    PostgrestResponse result = await Supabase.instance.client
        .from("todo-list")
        .select("id, name, duedate, description, done")
        .order('id', ascending: true)
        .range(from, from + 9)
        .execute();

    List<Todo> list = [];
    for (Map x in result.data) {
      Todo todo = Todo(
          id: x['id'],
          name: x["name"],
          description: x["description"],
          dueDate: DateTime.now(), //i cant find the exact time to same with db
          addDate: DateTime.now(),
          todoDone: x["done"]);
      list.add(todo);
    }

    return list;
  }

//..............................................
//read from db for search
  Future readDataSearch(int from, String str) async {
    PostgrestResponse result = await Supabase.instance.client
        .from("todo-list")
        .select("id, name, duedate, description, done")
        .ilike("name", '%$str%')
        .order('id', ascending: true)
        .range(from, from + 10)
        .execute();

    List<Todo> list = [];
    for (Map x in result.data) {
      Todo todo = Todo(
          id: x['id'],
          name: x["name"],
          description: x["description"],
          dueDate: DateTime.now(), //i cant find the exact time to same with db
          addDate: DateTime.now(),
          todoDone: x["done"]);
      list.add(todo);
    }

    return list;
  }
//...........................................

//add new todo db
  void addTodo(Todo todo) {
    Supabase.instance.client.from("todo-list").insert({
      "name": todo.name,
      //"duedate": DateTime.now().toUtc(),
      "description": todo.description,
      "done": false
    }).execute();
  }

  //.....................................

  //update todo db
  void updateTodo(Todo todo) {
    Supabase.instance.client
        .from("todo-list")
        .update({
          "name": todo.name,
          //"duedate": DateTime.now().toUtc(),
          "description": todo.description,
          "done": false
        })
        .eq('id', todo.id)
        .execute();
  }

  //.....................................
//delete todo db _______________________
  void deleteTodo(int id) {
    Supabase.instance.client.from("todo-list").delete().eq("id", id).execute();
  }
  //....................................

  void changeToggle(Todo todo) {
    Supabase.instance.client
        .from("todo-list")
        .update({"done": todo.todoDone})
        .eq("id", todo.id)
        .execute();
  }
}
