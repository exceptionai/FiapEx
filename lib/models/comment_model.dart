// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

import 'package:FiapEx/repository/db_connection.dart';

class CommentModel {
    int id;
    String message;
    DateTime date;
    int deliveryId;

    final String idColumn = DbConnection.commentTable["idColumn"];
    final String messageColumn = DbConnection.commentTable["messageColumn"];
    final String dateColumn = DbConnection.commentTable["dateColumn"];
    final String deliveryIdColumn = DbConnection.commentTable["fkDeliveryIdColumn"];

    CommentModel({
        this.id,
        this.message,
        this.date,
        this.deliveryId,
    });

    factory CommentModel.fromJson(String str) => CommentModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CommentModel.fromMap(Map<String, dynamic> json) => CommentModel(
        id: json["id"],
        message: json["message"],
        date: DateTime.parse(json["date"]),
        deliveryId: json["deliveryId"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "message": message,
        "date": date.toIso8601String(),
        "deliveryId": deliveryId,
    };
}
