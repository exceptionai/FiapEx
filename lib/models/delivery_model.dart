// To parse this JSON data, do
//
//     final deliveryModel = deliveryModelFromJson(jsonString);

import 'dart:convert';

class DeliveryModel {
    int id;
    DateTime deliveryDate;
    int grade;
    DateTime gradeGivenDate;
    int assignmentId;

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
        gradeGivenDate: DateTime.parse(json["gradeGivenDate"]),
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
