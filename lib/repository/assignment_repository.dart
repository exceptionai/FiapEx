import 'package:FiapEx/models/assignment_model.dart';

class AssignmentRepository {
  Future<List<AssignmentModel>> findAll() async {
    /*TODO: Change to db query*/

    List<AssignmentModel> assignments = List<AssignmentModel>();

    assignments.add(AssignmentModel(
        id: 1,
        endDate: DateTime.now(),
        observations: "blablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablabla",
        subject: "Trabalho 1",
        classId: 1,
        disciplineId: 1));

    assignments.add(AssignmentModel(
        id: 2,
        endDate: DateTime.now(),
        observations: "blablabla",
        subject: "Trabalho 2",
        classId: 1,
        disciplineId: 1));

    assignments.add(AssignmentModel(
        id: 3,
        endDate: DateTime.now(),
        observations: "blablabla",
        subject: "Trabalho 3",
        classId: 2,
        disciplineId: 2));

    return assignments;
  }

  Future<int> update(AssignmentModel assignmentModel) async {
    return 1; /* TODO: change to db query */
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