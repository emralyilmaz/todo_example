import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  final Function addTask;

  const AddTaskScreen({Key key, this.addTask}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String newTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text("Add your task"),
          TextField(
            onChanged: (val) {
              newTask = val;
            },
          ),
          FlatButton(
              onPressed: () {
                // widget.addTask(newTask);
                Navigator.pop(context, newTask);
              },
              child: Text("Add Task"))
        ],
      ),
    );
  }
}
