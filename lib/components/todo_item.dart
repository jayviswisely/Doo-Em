// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoItem extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? editFunction;

  ToDoItem({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Slidable(
        startActionPane:
            ActionPane(motion: StretchMotion(), extentRatio: 0.3, children: [
          SlidableAction(
            onPressed: editFunction,
            icon: Icons.edit,
            backgroundColor: Colors.indigo.shade500,
            borderRadius: BorderRadius.circular(12.0),
          )
        ]),
        endActionPane:
            ActionPane(motion: StretchMotion(), extentRatio: 0.3, children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.red.shade500,
            borderRadius: BorderRadius.circular(12.0),
          ),
        ]),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Checkbox(
                  activeColor: Colors.black54,
                  value: taskCompleted,
                  onChanged: onChanged),
              Text(
                taskName,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
