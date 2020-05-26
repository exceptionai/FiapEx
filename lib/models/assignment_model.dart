// To parse this JSON data, do
//
//     final assignmentModel = assignmentModelFromJson(jsonString);

import 'dart:convert';

import 'package:FiapEx/repository/db_connection.dart';

class AssignmentModel {
    int id;
    String subject;
    DateTime endDate;
    String observations;
    int classId;
    int disciplineId;

    final String idColumn = DbConnection.assignmentTable["idColumn"];
    final String subjectColumn = DbConnection.assignmentTable["subjectColumn"];
    final String endDateColumn = DbConnection.assignmentTable["endDateColumn"];
    final String observationsColumn = DbConnection.assignmentTable["observationsColumn"];
    final String classIdColumn = DbConnection.assignmentTable["fkClassIdColumn"];
    final String disciplineIdColumn = DbConnection.assignmentTable["fkDisciplineIdColumn"];

    AssignmentModel({
        this.id,
        this.subject,
        this.endDate,
        this.observations,
        this.classId,
        this.disciplineId,
    });

    factory AssignmentModel.fromJson(String str) => AssignmentModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AssignmentModel.fromMap(Map<String, dynamic> json) => AssignmentModel(
        id: json["id"],
        subject: json["subject"],
        endDate: DateTime.parse(json["endDate"]),
        observations: json["observations"],
        classId: json["classId"],
        disciplineId: json["disciplineId"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "subject": subject,
        "endDate": endDate.toIso8601String(),
        "observations": observations,
        "classId": classId,
        "disciplineId": disciplineId,
    };
}
