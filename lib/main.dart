import 'package:flutter/material.dart';
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

  await Hive.openBox('tasks');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:HomeScreen(),
      ),
    );
  }
}
