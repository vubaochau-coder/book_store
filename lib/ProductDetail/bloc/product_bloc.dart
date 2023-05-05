import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoadingState()) {
    on<ProductLoadingEvent>(productLoadingEvent);
  }

  FutureOr<void> productLoadingEvent(
      ProductLoadingEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
  }
}
