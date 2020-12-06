import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_hive/data/task_data.dart';
import 'package:provider/provider.dart';

class BottomSheetWidget extends StatefulWidget {
  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  int totalTask;
  String newTask;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff757575),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (task) {
                    newTask = task;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Task',
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                FlatButton(
                  onPressed: () {
                    if (newTask == null) {
                      Navigator.pop(context);
                    } else {
                      Provider.of<TaskList>(context, listen: false)
                          .addTask(newTask, DateTime.now());
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'ADD TASK',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      );
  }
}
