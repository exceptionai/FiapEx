import 'package:FiapEx/models/comment_model.dart';

class CommentRepository {
  Future<List<CommentModel>> findCommentsByDeliveryId(int deliveryId) async {
    /*TODO: change to db query*/

    List<CommentModel> comments = List<CommentModel>();

    if (deliveryId == 1) {
      comments.add(
        CommentModel(
            id: 1,
            message: "VOCÊ TEM TODA RAZÃO",
            date: DateTime.now(),
            deliveryId: 1),
      );

      comments.add(
        CommentModel(
            id: 2,
            message: "BACANA DEMAIS CARA",
            date: DateTime.now(),
            deliveryId: 1),
      );
    }

    return comments;
  }
}
