import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_first_app/hive/todo.dart';

const boxName = 'todoBox';

class HiveDb {
  HiveDb._();

  static final instance = HiveDb._();

  static Box? _box;

  Box get box {
    if (_box != null) return _box!;

    _box = initBox();
    return _box!;
  }

  Box initBox() => Hive.box(boxName);

//ADD
  void createTodo(Todo todo) {
    box.add(todo);
  }

//update
  void updateTodo(int index, Todo todo) {
    box.putAt(index, todo);
  }

  //delete
  void deleteTodo(int index) {
    box.deleteAt(index);
  }

  //addall
  ValueListenable<Box<dynamic>> getAll() {
    return box.listenable();
  }

  Todo getTodo(int index) {
   return box.getAt(index);
  }
}
