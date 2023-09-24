import 'package:bloc/bloc.dart';
import 'package:book_store/models/feedback_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'product_feedback_event.dart';
part 'product_feedback_state.dart';

class ProductFeedbackBloc
    extends Bloc<ProductFeedbackEvent, ProductFeedbackState> {
  ProductFeedbackBloc() : super(const ProductFeedbackState()) {
    on<ProductFeedbackLoadingEvent>(_onLoading);
    on<ProductFeedbackFilterEvent>(_onFilter);
  }

  _onLoading(ProductFeedbackLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    List<FeedbackModel> allFeedbacks = [];
    List<FeedbackModel> showedFeedbacks = [];

    final feedbackQuery = await FirebaseFirestore.instance
        .collection('Feedback')
        .where('bookID', isEqualTo: event.bookID)
        .orderBy('dateSubmit', descending: true)
        .get();

    for (var ele in feedbackQuery.docs) {
      allFeedbacks.add(FeedbackModel.fromSnaphot(ele));
    }

    showedFeedbacks = List.from(allFeedbacks);

    emit(
      state.copyWith(
        allFeedbacks: allFeedbacks,
        isLoading: false,
        showedFeedbacks: showedFeedbacks,
      ),
    );
  }

  _onFilter(ProductFeedbackFilterEvent event, Emitter emit) async {
    List<FeedbackModel> showed = [];

    if (event.sortType == FeedbackTypes.all) {
      showed = List.from(state.allFeedbacks);
    } else if (event.sortType == FeedbackTypes.one) {
      for (var ele in state.allFeedbacks) {
        if (ele.rating == 1) {
          showed.add(ele);
        }
      }
    } else if (event.sortType == FeedbackTypes.two) {
      for (var ele in state.allFeedbacks) {
        if (ele.rating == 2) {
          showed.add(ele);
        }
      }
    } else if (event.sortType == FeedbackTypes.three) {
      for (var ele in state.allFeedbacks) {
        if (ele.rating == 3) {
          showed.add(ele);
        }
      }
    } else if (event.sortType == FeedbackTypes.four) {
      for (var ele in state.allFeedbacks) {
        if (ele.rating == 4) {
          showed.add(ele);
        }
      }
    } else if (event.sortType == FeedbackTypes.five) {
      for (var ele in state.allFeedbacks) {
        if (ele.rating == 5) {
          showed.add(ele);
        }
      }
    }

    emit(
      state.copyWith(
        showedFeedbacks: showed,
        sortType: event.sortType,
      ),
    );
  }
}
