import 'package:book_store/core/repositories/address_repository.dart';
import 'package:book_store/core/repositories/book_repository.dart';
import 'package:book_store/core/repositories/cart_repository.dart';
import 'package:book_store/core/repositories/category_repository.dart';
import 'package:book_store/core/repositories/favorite_repository.dart';
import 'package:book_store/core/repositories/feedback_repository.dart';
import 'package:book_store/core/repositories/notification_repository.dart';
import 'package:book_store/core/repositories/transaction_repository.dart';

class MainRepository {
  late TransactionRepository transRepository;
  late NotificationRepository notiRepository;
  late BookRepository bookRepository;
  late FeedbackRepository feedbackRepository;
  late AddressRepository addressRepository;
  late FavoriteRepository favoriteRepository;
  late CategoryRepository categoryRepository;
  late CartRepository cartRepository;

  MainRepository() {
    transRepository = TransactionRepository();
    notiRepository = NotificationRepository();
    bookRepository = BookRepository();
    feedbackRepository = FeedbackRepository();
    addressRepository = AddressRepository();
    favoriteRepository = FavoriteRepository();
    categoryRepository = CategoryRepository();
    cartRepository = CartRepository();
  }
}
