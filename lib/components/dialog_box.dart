// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:to_do_app/components/buttons.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String hintText;
  final String initValue;
  final String title;
  final void Function(int) onPriorityChanged; // Add this line
  final int selectedPriority;

  DialogBox({
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.hintText,
    required this.initValue,
    required this.title,
    required this.onPriorityChanged, // Add this line
    required this.selectedPriority,
  });

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  int selectedPriority = 1; // Default priority value

  @override
  Widget build(BuildContext context) {
    widget.controller.text = widget.initValue;

    return AlertDialog(
      backgroundColor: Colors.green[200],
      content: Container(
        height: 170.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: widget.hintText,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.green.shade900, width: 2.0),
                  )),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Text(
                "*between 1-100 characters",
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.black54,
                ),
              ),
            ),
            // Priority Radio Buttons
            Column(
              children: [
                Row(
                  children: [
                    Radio<int>(
                      value: 1,
                      groupValue: selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          selectedPriority = value!;
                          widget.onPriorityChanged(selectedPriority);
                        });
                      },
                    ),
                    const Text('Low'),
                    Radio<int>(
                      value: 2,
                      groupValue: selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          selectedPriority = value!;
                          widget.onPriorityChanged(selectedPriority);
                        });
                      },
                    ),
                    const Text('Medium'),
                    Radio<int>(
                      value: 3,
                      groupValue: selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          selectedPriority = value!;
                          widget.onPriorityChanged(selectedPriority);
                        });
                      },
                    ),
                    const Text('High'),
                  ],
                ),
              ],
            ),
            //Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Save Button
                MyButton(text: "Save", onPressed: widget.onSave),

                //Gap
                const SizedBox(
                  width: 10.0,
                ),

                //Delete Button
                MyButton(text: "Cancel", onPressed: widget.onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
