import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_hive/data/task_data.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class BottomSheetWidget extends StatefulWidget {
  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  int totalTask;

  @override
  Widget build(BuildContext context) {
    Hive.openBox('tasks');
    String navoTask;
    return Scaffold(
      body: Container(
        color: Color(0xff757575),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  onChanged: (newTask) {
                    navoTask = newTask;
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
                    if (navoTask == null) {
                      Navigator.pop(context);
                    } else {
                      Provider.of<TaskList>(context, listen: false)
                          .addTask(navoTask, DateTime.now());

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
      ),
    );
  }
}
