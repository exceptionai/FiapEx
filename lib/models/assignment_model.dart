import 'dart:convert';

class AssignmentModel {
    int id;
    String subject;
    DateTime endDate;
    String observations;

    AssignmentModel({
        this.id,
        this.subject,
        this.endDate,
        this.observations,
    });

    factory AssignmentModel.fromJson(String str) => AssignmentModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AssignmentModel.fromMap(Map<String, dynamic> json) => AssignmentModel(
        id: json["id"],
        subject: json["subject"],
        endDate: DateTime.parse(json["endDate"]),
        observations: json["observations"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "subject": subject,
        "endDate": endDate.toIso8601String(),
        "observations": observations,
    };
}
