import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  //reference box
  final _myBox = Hive.box('mybox');

  //first time data
  void createInitialData() {
    toDoList = [
      ["Create your first task", false],
      ["Follow @jayviswiselyy on Instagram", false],
    ];
  }

  //load data from db
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update db
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
