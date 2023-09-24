import 'package:book_store/core/repositories/book_repository.dart';
import 'package:book_store/core/repositories/feedback_repository.dart';
import 'package:book_store/core/repositories/notification_repository.dart';
import 'package:book_store/core/repositories/transaction_repository.dart';

class MainRepository {
  late TransactionRepository transRepository;
  late NotificationRepository notiRepository;
  late BookRepository bookRepository;
  late FeedbackRepository feedbackRepository;

  MainRepository() {
    transRepository = TransactionRepository();
    notiRepository = NotificationRepository();
    bookRepository = BookRepository();
    feedbackRepository = FeedbackRepository();
  }
}
