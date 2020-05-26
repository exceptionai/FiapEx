import 'package:FiapEx/models/delivery_model.dart';
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

  Future<List<DeliveryModel>> findDeliveriesByAssignmentId(
      int assignmentId) async {
    /*TODO: Change to db query*/

    /*List<DeliveryModel> deliveries = List<DeliveryModel>();

    deliveries.add(
      DeliveryModel(
        id: 1,
        assignmentId: 1,
        deliveryDate: DateTime.now(),
        grade: null,
        gradeGivenDate: null,
      ),
    );

    deliveries.add(
      DeliveryModel(
        id: 2,
        assignmentId: 2,
        deliveryDate: DateTime.now(),
        grade: 3,
        gradeGivenDate: DateTime.now(),
      ),
    );

    return deliveries;*/

    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT * FROM $table WHERE assignmentId = $assignmentId;");
    List<DeliveryModel> listModel = List();
    for (Map m in listMap) {
      listModel.add(DeliveryModel.fromMap(m));
    }
    return listModel;
  }
  Future<List<DeliveryModel>> findStudentsByDeliveryId(int id) async {
    /*TODO: Change to db query*/

    List<DeliveryModel> deliveries = List<DeliveryModel>();

    deliveries.add(
      DeliveryModel(
        id: 1,
        assignmentId: 1,
        deliveryDate: DateTime.now(),
        grade: null,
        gradeGivenDate: DateTime.now(),
      ),
    );

    deliveries.add(
      DeliveryModel(
        id: 2,
        assignmentId: 2,
        deliveryDate: DateTime.now(),
        grade: 3,
        gradeGivenDate: DateTime.now(),
      ),
    );

    return deliveries;
  }

  Future<int> update(DeliveryModel deliveryModel) async {
    /* TODO: change to db query */

    return 1;
  }

}
