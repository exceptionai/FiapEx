import 'package:FiapEx/models/discipline_model.dart';
import 'package:FiapEx/repository/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class DisciplineRepository{

  final DbConnection dbConnection = DbConnection();
  final String table = DbConnection.disciplineTable["tableName"];
  final String tableClassDisciplineName = DbConnection.classDisciplineTable["tableName"];
  final String idColumn = DbConnection.disciplineTable["idColumn"];
  final String nameColumn = DbConnection.disciplineTable["nameColumn"];
  final String classColumnClassDiscipline = DbConnection.classDisciplineTable["fkClassColumn"];
  final String idColumnClassDiscipline = DbConnection.classDisciplineTable["fkDisciplineColumn"];

  Future<List> getAllDisciplines() async {
    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT * FROM $table;");
    List<DisciplineModel> listModel = List();
    for(Map m in listMap){
      listModel.add(DisciplineModel.fromMap(m));
    }
    return listModel;
  }

  getAllDisciplinesByClass({int classId}) async {
    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT d.* FROM $tableClassDisciplineName cd INNER JOIN $table d ON d.$idColumn = cd.$idColumnClassDiscipline WHERE cd.$classColumnClassDiscipline = $classId ;");
    List<DisciplineModel> listModel = List();
    for(Map m in listMap){
      listModel.add(DisciplineModel.fromMap(m));
    }
    return listModel;
  }

  Future<DisciplineModel> saveDiscipline(DisciplineModel model) async {
    Database db = await dbConnection.db;
    model.id = await db.insert(table, model.toMap());
    return model;
  }

  Future<DisciplineModel> getDiscipline(int id) async {
    Database db = await dbConnection.db;
    List<Map> maps = await db.query(table,
      columns: [idColumn, nameColumn],
      where: "$idColumn = ?",
      whereArgs: [id]);
    if(maps.length > 0){
      return DisciplineModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteDiscipline(int id) async {
    Database db = await dbConnection.db;
    return await db.delete(table, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateDiscipline(DisciplineModel model) async {
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