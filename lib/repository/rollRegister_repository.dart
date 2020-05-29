import 'package:FiapEx/models/student.dart';
import 'package:FiapEx/repository/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class RollRegisterRepository{

  final DbConnection dbConnection = DbConnection();
  final String rollRegisterTable = DbConnection.rollRegisterTable["tableName"];
  final String idRollRegisterColumn = DbConnection.rollRegisterTable["idRollRegisterColumn"];
  final String idStudentColumn = DbConnection.rollRegisterTable["fkStudentColumn"];
  final String idRollColumn = DbConnection.rollRegisterTable["fkRollColumn"];
  final String presenceColumn = DbConnection.rollRegisterTable["presenceColumn"];
  final String registerDateColumn = DbConnection.rollRegisterTable["registerDateColumn"];

  final String studentTable = DbConnection.studentTable["tableName"];
  final String studentRm = DbConnection.studentTable["idColumn"];
  final String studentName = DbConnection.studentTable["nameColumn"];


  Future<List> getAllRollRegisters() async {
    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT * FROM $rollRegisterTable");
    return listMap;
  }

  Future<bool> saveRollRegister(int idRoll, int idStudent, String presence) async {
    Database db = await dbConnection.db;

    Map <String,dynamic> map = {
      idStudentColumn : idStudent,
      idRollColumn : idRoll,
      presenceColumn : presence,
      registerDateColumn : DateTime.now().toString()
    };
    
    int id = await db.insert(rollRegisterTable, map);
    if(id != null){
      return true;
    }else{
      return false;
    }

  }

  Future<List<Map>> getRollRegisterByRollid(int id) async {
    Database db = await dbConnection.db;
    List<Map> maps = await db.rawQuery(""" 
      SELECT s.$studentRm, s.$studentName, r.$presenceColumn, r.$registerDateColumn
        FROM $rollRegisterTable AS r, $studentTable AS s
          WHERE r.$idRollColumn = $id AND r.$idStudentColumn = s.$studentRm;""");
    return maps;
  }

  Future<bool> deleteRoll(int id) async {
    Database db = await dbConnection.db;
    var resp = await db.rawQuery("""UPDATE $rollRegisterTable 
      SET $presenceColumn = '' WHERE $idRollRegisterColumn = $id""");
    if (resp != null){
      return true;
    }else{
      return false;
    }
  }

  Future<int> presentStudentsCount(rowCallId) async{

    Database db = await dbConnection.db;
    int quantidade = Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM $rollRegisterTable WHERE $idRollColumn = $rowCallId"));
    return quantidade;

  }

   /*Future<int> changePresence(String presence) async {
    Database db = await dbConnection.db;
    return await db.update(table,
        model.toMap(),
        where: "$idColumn = ?",
        whereArgs: [model.id]);
  }*/

  
  Future<int> getNumber() async {
    Database db = await dbConnection.db;
    return Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM $rollRegisterTable"));
  }

  Future close() async {
    Database db = await dbConnection.db;
    db.close();
  }


}