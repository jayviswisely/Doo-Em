import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  //reference box
  final _myBox = Hive.box('mybox');

  //first time data
  void createInitialData() {
    toDoList = [
      ["Follow @jayviswiselyy on Instagram", false, 3],
      ["Create a new task!", false, 2],
      ["Try swiping me left or right!", false, 1],2
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
