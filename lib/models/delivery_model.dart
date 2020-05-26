// To parse this JSON data, do
//
//     final deliveryModel = deliveryModelFromJson(jsonString);

import 'dart:convert';

import 'package:FiapEx/repository/db_connection.dart';

class DeliveryModel {
    int id;
    DateTime deliveryDate;
    double grade;
    DateTime gradeGivenDate;
    int assignmentId;

    final String idColumn = DbConnection.deliveryTable["idColumn"];
    final String deliveryDateColumn = DbConnection.deliveryTable["deliveryDateColumn"];
    final String gradeColumn = DbConnection.deliveryTable["gradeColumn"];
    final String gradeGivenDateColumn = DbConnection.deliveryTable["gradeGivenDateColumn"];
    final String assignmentIdColumn = DbConnection.deliveryTable["fkAssignmentIdColumn"];

    DeliveryModel({
        this.id,
        this.deliveryDate,
        this.grade,
        this.gradeGivenDate,
        this.assignmentId,
    });

    factory DeliveryModel.fromJson(String str) => DeliveryModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DeliveryModel.fromMap(Map<String, dynamic> json) => DeliveryModel(
        id: json["id"],
        deliveryDate: DateTime.parse(json["deliveryDate"]),
        grade: json["grade"],
        gradeGivenDate: json["gradeGivenDate"] != null ? DateTime.parse(json["gradeGivenDate"]) : null,
        assignmentId: json["assignmentId"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "deliveryDate": deliveryDate.toIso8601String(),
        "grade": grade,
        "gradeGivenDate": gradeGivenDate.toIso8601String(),
        "assignmentId": assignmentId,
    };
}
