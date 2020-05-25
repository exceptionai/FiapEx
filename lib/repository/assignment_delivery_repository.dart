import 'package:FiapEx/models/delivery_model.dart';

class AssignmentDeliveryRepository {
  Future<List<DeliveryModel>> findDeliveriesByAssignmentId(
      int assignmentId) async {
    /*TODO: Change to db query*/

    List<DeliveryModel> deliveries = List<DeliveryModel>();

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

    return deliveries;
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
