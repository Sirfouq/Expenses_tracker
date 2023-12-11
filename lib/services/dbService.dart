// ignore_for_file: curly_braces_in_flow_control_structures


import 'package:expenses_tracker/model/tableschema.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbService<T> {

  final String tablename;
  final String dbname;
  final int version;
  final TableSchema columns;
  final T Function(Map<String,dynamic>) fromMap;
  final Map<String,dynamic> Function(T) toMap;
  Database? _db;

  DbService({required this.tablename,required this.dbname,required this.version,required this.columns,required this.fromMap,required this.toMap});

  Future<Database?> get database async {
    if(_db!=null)
      return _db;
    _db = await init_db();
    return _db;
  }

   init_db() async{
    String columnDefinitions = columns.columns.join(', ');
    return await openDatabase(
      join(await getDatabasesPath(),dbname ),
      version: version,
      onCreate:(db, version) => db.execute('CREATE TABLE $tablename($columnDefinitions)'),
      

    );
  }
 
  Future<int> insert(T item) async{
    final db = await database;
    return await db!.insert(tablename, toMap(item));
  }

  Future<T?> getItem(int id) async{
    final db = await database;
    List<Map<String,dynamic>> results = await db!.query(tablename,where : 'id =?',whereArgs: [id]);
    return fromMap(results.first);
  }

  Future<List<T>> getall() async{
    final db = await database;
    var results = await db!.query(tablename);
    return results.map<T>((item) => fromMap(item)).toList();
  }

  Future<int> update(T item)async{
    final db = await database;
    return await db!.update(tablename, toMap(item),where: 'id = ?',whereArgs:[(item as dynamic).id]);
  }

  Future<int> delete(int id)async{
    final db = await database;
    return await db!.delete(tablename,where: 'id = ?',whereArgs: [id]);
  }
    
  }
   
