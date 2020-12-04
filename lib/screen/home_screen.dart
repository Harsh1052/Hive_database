import 'package:flutter/material.dart';
import 'package:flutter_todo_hive/data/task_data.dart';
import 'package:flutter_todo_hive/widgets/bottomsheet_widget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Hive.openBox('tasks');
    for (int i = 0; i < Hive.box('tasks').length; i++) {
      final box = Hive.box('tasks').getAt(i) as TaskData;
      Provider.of<TaskList>(context).tasksList.add(box);
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => BottomSheetWidget());
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
                  child: WatchBoxBuilder(
                      box: Hive.box('tasks'),
                      builder: (context, box) {
                        Hive.openBox('tasks');

                        return ListView.builder(
                          itemBuilder: (context, index) {
                            Hive.openBox('tasks');
                            final newBox = box.getAt(index) as TaskData;
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
                                      box.put(
                                          index,
                                          TaskData(
                                              currentDate:
                                                  DateTime.now().day.toString(),
                                              currentMonth: DateTime.now()
                                                  .month
                                                  .toString(),
                                              currentYear: DateTime.now()
                                                  .year
                                                  .toString(),
                                              title: newBox.title,
                                              isCompleted: newValue));
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
                                      '${newBox.currentDate}/${newBox.currentMonth}/${newBox.currentYear}'),
                                ),
                              ],
                            );
                          },
                          itemCount: Hive.box('tasks').length,
                        );
                      })),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Hive.close();
  }
}
