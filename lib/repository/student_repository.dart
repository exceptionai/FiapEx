import 'package:FiapEx/models/student.dart';
import 'package:FiapEx/repository/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class StudentRepository{

  final DbConnection dbConnection = DbConnection();
  final String table = DbConnection.studentTable["tableName"];
  final String idColumn = DbConnection.studentTable["idColumn"];
  final String nameColumn = DbConnection.studentTable["nameColumn"];
  final String idClassColumn = DbConnection.studentTable["classFkColumn"];

  Future<List<StudentModel>> getAllStudentsByClass(int idClass) async {
    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT * FROM $table WHERE $idClassColumn = $idClass;");
    List<StudentModel> listModel = List();
    for(Map m in listMap){
      listModel.add(StudentModel.fromMap(m));
    }
    return listModel;
  }



  Future<StudentModel> saveStudent(StudentModel model) async {
    Database db = await dbConnection.db;
    model.id = await db.insert(table, model.toMap());
    return model;
  }

  Future<StudentModel> getStudent(int id) async {
    Database db = await dbConnection.db;
    List<Map> maps = await db.query(table,
      columns: [idColumn, nameColumn],
      where: "$idColumn = ?",
      whereArgs: [id]);
    if(maps.length > 0){
      return StudentModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteStudent(int id) async {
    Database db = await dbConnection.db;
    return await db.delete(table, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateStudent(StudentModel model) async {
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