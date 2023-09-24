import 'package:book_store/core/services/my_feedback_service.dart';

class FeedbackRepository {
  late MyFeedbackService _myFeedbackService;

  FeedbackRepository() {
    _myFeedbackService = MyFeedbackService();
  }

  Future<void> addNewFeedback(
      String bookId, String bookTitle, double price, String img) async {
    return _myFeedbackService.addNewFeedback(bookId, bookTitle, price, img);
  }
}
