import 'package:FiapEx/models/comment_model.dart';
import 'package:sqflite/sqflite.dart';

import 'db_connection.dart';

class CommentRepository {
  
  final DbConnection dbConnection = DbConnection();
  final String table = DbConnection.commentTable["tableName"];
  final String idColumn = DbConnection.commentTable["idColumn"];
  final String messageColumn = DbConnection.commentTable["messageColumn"];
  final String dateColumn = DbConnection.commentTable["dateColumn"];
  final String deliveryIdColumn = DbConnection.commentTable["deliveryIdColumn"];

  Future<List<CommentModel>> findCommentsByDeliveryId(int deliveryId) async {
    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT * FROM $table WHERE deliveryId = $deliveryId;");
    List<CommentModel> listModel = List();
    for (Map m in listMap) {
      listModel.add(CommentModel.fromMap(m));
    }
    return listModel;
  }

  Future<int> create(CommentModel model) async {
    Database db = await dbConnection.db;
    model.id = await db.insert(table, model.toMap());
    return model.id;
  }
}
