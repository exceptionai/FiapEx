import 'package:FiapEx/models/delivery_model.dart';
import 'package:FiapEx/models/student.dart';
import 'package:sqflite/sqflite.dart';

import 'db_connection.dart';

class AssignmentDeliveryRepository {

  final DbConnection dbConnection = DbConnection();
  final String table = DbConnection.deliveryTable["tableName"];
  final String idColumn = DbConnection.deliveryTable["idColumn"];
  final String deliveryDateColumn = DbConnection.deliveryTable["deliveryDateColumn"];
  final String gradeColumn = DbConnection.deliveryTable["gradeColumn"];
  final String gradeGivenDateColumn = DbConnection.deliveryTable["gradeGivenDateColumn"];
  final String assignmentIdColumn = DbConnection.deliveryTable["assignmentIdColumn"];

  final String deliveryStudentTable = DbConnection.deliveryStudentTable["tableName"];
  final String deliveryStudentTableRm = DbConnection.deliveryStudentTable["fkStudentRmColumn"];
  final String studentTable = DbConnection.studentTable["tableName"];
  final String rm = DbConnection.studentTable["idColumn"];

  Future<List<DeliveryModel>> findDeliveriesByAssignmentId(
      int assignmentId) async {
    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT * FROM $table WHERE assignmentId = $assignmentId;");
    List<DeliveryModel> listModel = List();
    for (Map m in listMap) {
      listModel.add(DeliveryModel.fromMap(m));
    }
    return listModel;
  }
  Future<List<StudentModel>> findStudentsByDeliveryId(int id) async {
    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT * FROM $deliveryStudentTable AS ds JOIN $studentTable AS s ON(s.$rm = ds.$deliveryStudentTableRm) WHERE deliveryId = $id;");
    List<StudentModel> listModel = List();
    for (Map m in listMap) {
      listModel.add(StudentModel.fromMap(m));
    }
    return listModel;
  }

  Future<int> update(DeliveryModel model) async {
    Database db = await dbConnection.db;
    return await db.update(table,
        model.toMap(),
        where: "$idColumn = ?",
        whereArgs: [model.id]);
  }

}
