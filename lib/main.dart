import 'dart:io';

import 'package:expenses_tracker/model/expenseCategory.dart';
import 'package:expenses_tracker/model/tableschema.dart';
import 'package:expenses_tracker/services/dbService.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) {
    DbService<ExpenseCategory> expenseCategoryService = DbService(
        tablename: 'ExpenseCategory',
        dbname: 'localDB',
        version: 1,
        columns: TableSchema(
            columns: ['id INTEGER PRIMARY KEY AUTOINCREMENT', 'name TEXT','icon_codekey TEXT']),
        fromMap: (map) => ExpenseCategory.fromMap(map),
        toMap: (ExpenseCategory) => ExpenseCategory.toMap());

    await initializeCategories(expenseCategoryService);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
    );
  }
}

Future<void> initializeCategories(DbService<ExpenseCategory> service) async {
  List<ExpenseCategory> categories = [
    ExpenseCategory(name: 'Housing',icon_codekey: Icons.house.codePoint.toString()),
    ExpenseCategory(name: 'Utilities',icon_codekey: Icons.power.codePoint.toString())
  ];
  for (var expenseCategory in categories) await service.insert(expenseCategory);
}
