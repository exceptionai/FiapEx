import 'package:FiapEx/models/roll_model.dart';
import 'package:FiapEx/repository/db_connection.dart';
import 'package:sqflite/sqflite.dart';


class RollRepository{

  final DbConnection dbConnection = DbConnection();
  final String table = DbConnection.rollTable["tableName"];
  final String idColumn = DbConnection.rollTable["idColumn"];
  final String nameColumn = DbConnection.rollTable["nameColumn"];
  final String doneColumn = DbConnection.rollTable["doneColumn"];
  final String dateColumn = DbConnection.rollTable["dateColumn"];
 
  Future<List<RollModel>> getAllRolles() async {
    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT * FROM $table ORDER BY $dateColumn DESC;");
    List<RollModel> listModel = List();
    for(Map m in listMap){
      listModel.add(RollModel.fromMap(m));
    }
    return listModel;
  }

  Future<int> finishRowCall({int rowCallId, String date}) async{
    Database db = await dbConnection.db;

    return await db.rawUpdate("UPDATE $table SET $doneColumn = 1, $dateColumn = '$date' WHERE $idColumn = $rowCallId");
  }

  Future<RollModel> saveRoll(RollModel model) async {
    Database db = await dbConnection.db;
    model.id = await db.insert(table, model.toMap());
    return model;
  }

  Future<RollModel> getRoll(int id) async {
    Database db = await dbConnection.db;
    List<Map> maps = await db.query(table,
      columns: [idColumn, nameColumn],
      where: "$idColumn = ?",
      whereArgs: [id]);
    if(maps.length > 0){
      return RollModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteRoll(int id) async {
    Database db = await dbConnection.db;
    return await db.delete(table, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateRoll(RollModel model) async {
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