// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:to_do_app/components/buttons.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  final String hintText;
  final String initValue;
  final String title;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.hintText,
    required this.initValue,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    controller.text = initValue;

    return AlertDialog(
      backgroundColor: Colors.green[200],
      content: Container(
        height: 130.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: hintText,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.green.shade900, width: 2.0),
                  )),
            ),
            //Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Save Button
                MyButton(text: "Save", onPressed: onSave),

                //Gap
                SizedBox(
                  width: 10.0,
                ),

                //Delete Button
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
