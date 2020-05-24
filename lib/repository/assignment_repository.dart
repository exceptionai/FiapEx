import 'package:FiapEx/models/assignment_model.dart';

class AssignmentRepository {

  Future<List<AssignmentModel>> findAll() async {
    /*TODO: Change to db query*/

    List<AssignmentModel> assignments = List<AssignmentModel>();

    assignments.add(AssignmentModel(
        id: 1,
        endDate: DateTime.now(),
        observations: "blablabla",
        subject: "Trabalho 1"));

    assignments.add(AssignmentModel(
        id: 2,
        endDate: DateTime.now(),
        observations: "blablabla",
        subject: "Trabalho 2"));

    assignments.add(AssignmentModel(
        id: 3,
        endDate: DateTime.now(),
        observations: "blablabla",
        subject: "Trabalho 3"));

    return assignments;
  }

  Future<int> getDeliveryAmount(int assignmentId, String type) async {
    if (type == "all") {
      return 0; /*TODO: Change to db query*/
    } else if (type == "nonRated") {
      return 0; /*TODO: Change to db query*/
    } else if (type == "rated") {
      return 0; /*TODO: Change to db query*/
    }
  }
}