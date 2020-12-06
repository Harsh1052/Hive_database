import 'package:flutter/material.dart';
import 'package:flutter_todo_hive/data/task_data.dart';
import 'package:flutter_todo_hive/widgets/bottomsheet_widget.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../data/task_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    List<TaskData> list = [];
    for (int i = 0; i < Hive.box('tasks').length; i++) {
      final box = Hive.box('tasks').getAt(i) as TaskData;
      list.add(box);
    }
    Provider.of<TaskList>(context,listen: false).setTaskList(list);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: BottomSheetWidget(),
                ),
              ));
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Container(
                      padding: EdgeInsets.all(13.0),
                      child: Icon(
                        Icons.menu,
                        color: Colors.blue,
                      ),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'TO DO APP',
                    style: titleText,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Total Task: ${Provider.of<TaskList>(context).tasksList.length}',
                    style: subTitleText,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Center(
              child: Text(
                'Your Task',
                style: titleText,
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0)),
                  ),
                  // ignore: deprecated_member_use
                  child:Consumer<TaskList>(
                    builder:(context,data,child) {
                      print('length is ${data.tasksList.length}');
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final newBox = data.tasksList[index];
                          return Column(
                            children: [
                              ListTile(
                                title: Text(
                                  newBox.title,
                                  style: TextStyle(
                                      color: newBox.isCompleted
                                          ? Colors.grey
                                          : Colors.black,
                                      decoration: newBox.isCompleted
                                          ? TextDecoration.lineThrough
                                          : null),
                                ),
                                trailing: Checkbox(
                                  value: newBox.isCompleted,
                                  onChanged: (newValue) {
                                    Provider.of<TaskList>(context,listen: false).toggleTask(index);
                                  },
                                ),
                                leading: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                onLongPress: () {
                                  Provider.of<TaskList>(context,
                                      listen: false)
                                      .deleteTask(index);
                                },
                                subtitle: Text(
                                    '${newBox.currentDate}/${newBox
                                        .currentMonth}/${newBox.currentYear}'),
                              ),
                            ],
                          );
                        },
                        itemCount: data.tasksList.length,
                      );
                    }
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //Hive.close();
  }
}
