import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/components/dialog_box.dart';
import 'package:to_do_app/components/todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the 1st time ever opening the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask(int selectedPriority) {
    String taskText = _controller.text.trim();

    if (taskText.isNotEmpty && taskText.length <= 100) {
      setState(() {
        db.toDoList.add([taskText, false, selectedPriority]);
        _controller.clear();
      });
      Navigator.of(context).pop();
      db.updateDataBase();
    } else {
      // Display an error message or perform any desired action
      // to handle invalid input.
    }
  }

  // create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        int selectedPriority = 1; // Default priority value
        return DialogBox(
          controller: _controller,
          onSave: () => saveNewTask(selectedPriority),
          onCancel: () => Navigator.of(context).pop(),
          hintText: "e.g. follow @jayviswiselyy",
          initValue: "",
          title: "Create a New Task",
          onPriorityChanged: (priority) {
            selectedPriority = priority;
          },
          selectedPriority: 1,
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  // edit task
  void editTask(int index) {
    setState(() {
      showDialog(
        context: context,
        builder: (context) {
          int selectedPriority = db.toDoList[index][2];
          return DialogBox(
            controller: _controller,
            onSave: () => renewTask(index, selectedPriority),
            onCancel: () => Navigator.of(context).pop(),
            hintText: "e.g. follow @jayviswiselyy",
            initValue: db.toDoList[index][0],
            title: "Edit an Existing Task",
            onPriorityChanged: (priority) {
              selectedPriority = priority;
            },
            selectedPriority: db.toDoList[index][2],
          );
        },
      );
    });
  }

  //renew edited task
  void renewTask(int index, selectedPriority) {
    setState(() {
      db.toDoList[index][0] = _controller.text;
      db.toDoList[index][2] = selectedPriority;
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text("Doo'Em!"),
        ),
        titleTextStyle: const TextStyle(
            color: Colors.black54, fontWeight: FontWeight.w600, fontSize: 20.0),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/help');
              },
              icon: Icon(
                Icons.help,
                color: Colors.green[900],
                size: 28.0,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: createNewTask,
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.black54,
          ),
        ),
      ),
      body: Column(
        children: [
          if (db.toDoList.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/emptytask.png',
                      width: 320,
                    ),
                    const Text(
                      "Start creating your first task!",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: db.toDoList.length + 1, // Add 1 for the empty box
                itemBuilder: (context, index) {
                  if (index == db.toDoList.length) {
                    // Render empty box
                    return SizedBox(
                      height: 30,
                    );
                  } else {
                    // Sort the list based on priority
                    db.toDoList.sort((a, b) => b[2].compareTo(a[2]));

                    // Check if a new priority group is starting
                    if (index == 0 ||
                        db.toDoList[index][2] != db.toDoList[index - 1][2]) {
                      // Render priority group title
                      String priorityTitle = '';

                      // Check priority value and set the title accordingly
                      if (db.toDoList[index][2] == 3) {
                        priorityTitle = 'High Priority';
                      } else if (db.toDoList[index][2] == 2) {
                        priorityTitle = 'Medium Priority';
                      } else if (db.toDoList[index][2] == 1) {
                        priorityTitle = 'Low Priority';
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                priorityTitle,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                          ToDoItem(
                            taskName: db.toDoList[index][0],
                            taskCompleted: db.toDoList[index][1],
                            taskPriority: db.toDoList[index][2],
                            onChanged: (value) => checkBoxChanged(value, index),
                            deleteFunction: (context) => deleteTask(index),
                            editFunction: (context) => editTask(index),
                          ),
                        ],
                      );
                    } else {
                      // Render regular item
                      return ToDoItem(
                        taskName: db.toDoList[index][0],
                        taskCompleted: db.toDoList[index][1],
                        taskPriority: db.toDoList[index][2],
                        onChanged: (value) => checkBoxChanged(value, index),
                        deleteFunction: (context) => deleteTask(index),
                        editFunction: (context) => editTask(index),
                      );
                    }
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
