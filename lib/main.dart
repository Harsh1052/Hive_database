import 'package:flutter/material.dart';
import 'package:flutter_todo_hive/constants.dart';
import 'package:flutter_todo_hive/data/task_data.dart';
import 'package:flutter_todo_hive/screen/home_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pathProvider = await path_provider.getApplicationDocumentsDirectory();

  Hive.init(pathProvider.path);
  Hive.registerAdapter(TaskDataAdapter());

  runApp(MyApp());
  Hive.openBox('tasks');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Hive.openBox('tasks');
    return ChangeNotifierProvider(
      create: (context) => TaskList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: Hive.openBox('tasks'),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Scaffold(
                      body: Center(
                          child: Text(
                    snapshot.error.toString(),
                    style: errorTitle,
                  ))),
                );
              } else {
                return HomeScreen();
              }
            } else {
              return Center(
                child: Scaffold(
                    body: Center(
                  child: Text(
                    'Loading Your Data',
                    style: errorTitle,
                  ),
                )),
              );
            }
          },
        ),
      ),
    );
  }
}
