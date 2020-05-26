import 'package:FiapEx/models/assignment_model.dart';
import 'package:sqflite/sqflite.dart';

import 'db_connection.dart';

class AssignmentRepository {
  final DbConnection dbConnection = DbConnection();
  final String table = DbConnection.assignmentTable["tableName"];
  final String idColumn = DbConnection.assignmentTable["idColumn"];
  final String subjectColumn = DbConnection.assignmentTable["subjectColumn"];
  final String endDateColumn = DbConnection.assignmentTable["endDateColumn"];
  final String observationsColumn =
      DbConnection.assignmentTable["observationsColumn"];
  final String classIdColumn = DbConnection.assignmentTable["classIdColumn"];
  final String disciplineIdColumn =
      DbConnection.assignmentTable["disciplineIdColumn"];

  Future<List<AssignmentModel>> findAll() async {
    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT * FROM $table;");
    List<AssignmentModel> listModel = List();
    for (Map m in listMap) {
      listModel.add(AssignmentModel.fromMap(m));
    }
    return listModel;
  }

  Future<int> update(AssignmentModel model) async {
    Database db = await dbConnection.db;
    return await db.update(table, model.toMap(),
        where: "$idColumn = ?", whereArgs: [model.id]);
  }

  Future<int> getDeliveryAmount(int assignmentId, String type) async {
    if (type == "all") {
      return 0; /*TODO: Change to db query*/
    } else if (type == "nonRated") {
      return 0; /*TODO: Change to db query*/
    } else {
      return 0; /*TODO: Change to db query*/
    }
  }
}
