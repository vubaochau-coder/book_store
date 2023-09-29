import 'package:book_store/core/models/feedback_model.dart';
import 'package:book_store/core/services/feedback_service.dart';

class FeedbackRepository {
  late FeedbackService _feedbackService;

  FeedbackRepository() {
    _feedbackService = FeedbackService();
  }

  Future<void> addNewFeedback(
      String bookId, String bookTitle, double price, String img) async {
    return await _feedbackService.addNewFeedback(bookId, bookTitle, price, img);
  }

  Future<List<FeedbackModel>> getLimitFeedback(String bookId, int limit) async {
    return await _feedbackService.getLimitFeedback(bookId, limit);
  }

  Future<List<FeedbackModel>> getAllFeedback(String bookId) async {
    return await _feedbackService.getAllFeedback(bookId);
  }
}
