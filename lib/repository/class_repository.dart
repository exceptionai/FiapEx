import 'package:FiapEx/repository/db_connection.dart';
import 'package:sqflite/sqflite.dart';

import '../models/class_model.dart';

class ClassRepository{

  final DbConnection dbConnection = DbConnection();
  final String table = DbConnection.classTable["tableName"];
  final String idColumn = DbConnection.classTable["idColumn"];
  final String nameColumn = DbConnection.classTable["nameColumn"];

  Future<List> getAllClasses() async {
    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT * FROM $table;");
    List<ClassModel> listModel = List();
    for(Map m in listMap){
      listModel.add(ClassModel.fromMap(m));
    }
    return listModel;
  }

  Future<ClassModel> saveClass(ClassModel model) async {
    Database db = await dbConnection.db;
    model.id = await db.insert(table, model.toMap());
    return model;
  }

  Future<ClassModel> getClass(int id) async {
    Database db = await dbConnection.db;
    List<Map> maps = await db.query(table,
      columns: [idColumn, nameColumn],
      where: "$idColumn = ?",
      whereArgs: [id]);
    if(maps.length > 0){
      return ClassModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteClass(int id) async {
    Database db = await dbConnection.db;
    return await db.delete(table, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateClass(ClassModel model) async {
    Database db = await dbConnection.db;
    return await db.update(table,
        model.toMap(),
        where: "$idColumn = ?",
        whereArgs: [model.id]);
  }

  
  Future<int> getNumber() async {
    Database db = await dbConnection.db;
    return Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM $table"));
  }

  Future close() async {
    Database db = await dbConnection.db;
    db.close();
  }


}