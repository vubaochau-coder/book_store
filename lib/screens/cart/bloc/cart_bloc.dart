import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/cart_item_model.dart';
import 'package:book_store/core/repositories/cart_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  StreamSubscription? _cartStream;
  final CartRepository _cartRepository;

  CartBloc(this._cartRepository) : super(const CartState()) {
    on<CartLoadingEvent>(_onLoading);
    on<CartAllItemSelectedEvent>(_onAllItemSelected);
    on<CartChangeItemQuantityEvent>(_onChangeItemQuantity);
    on<CartRemoveItemEvent>(_onRemoveItem);
    on<CartItemSelectedEvent>(_onItemSelected);
    on<CartAddItemEvent>(_onAddItem);
    on<CartUpdateEvent>(_onUpdate);
    on<CartUpdateEmptyEvent>(_onUpdateEmpty);
  }

  @override
  Future<void> close() async {
    _cartStream?.cancel();
    _cartStream = null;
    super.close();
  }

  _onLoading(CartLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    _cartStream = _cartRepository.cartStream().listen((event) async {
      if (event.docs.isNotEmpty) {
        final getAllBooks = await Future.wait([
          ...event.docs.map((e) => _cartRepository.getBook(e)),
        ]);

        add(CartUpdateEvent(listCart: getAllBooks));
      } else {
        add(CartUpdateEmptyEvent());
      }
    });
  }

  _onAllItemSelected(CartAllItemSelectedEvent event, Emitter emit) {
    if (state.selectedCartitems.length < state.cartItems.length) {
      emit(
        state.copyWith(
          selectedCartitems: List.from(state.cartItems),
          isAllSelected: true,
        ),
      );
    } else {
      emit(
        state.copyWith(selectedCartitems: [], isAllSelected: false),
      );
    }
  }

  _onChangeItemQuantity(CartChangeItemQuantityEvent event, Emitter emit) {
    List<CartItemModel> newCartItem = List.from(state.cartItems);
    bool check = state.selectedCartitems.contains(event.item);

    CartItemModel model = CartItemModel(
      id: event.item.id,
      bookID: event.item.bookID,
      count: event.isIncrease ? event.item.count + 1 : event.item.count - 1,
      price: event.item.price,
      imgUrl: event.item.imgUrl,
      title: event.item.title,
      priceBeforeDiscount: event.item.priceBeforeDiscount,
    );

    if (check) {
      List<CartItemModel> newSelectedCartItem =
          List.from(state.selectedCartitems);

      int index = newSelectedCartItem.indexOf(event.item);

      newSelectedCartItem[index] = model;
      emit(state.copyWith(selectedCartitems: newSelectedCartItem));
    }

    int index = newCartItem.indexOf(event.item);
    newCartItem[index] = model;

    emit(state.copyWith(cartItems: newCartItem));
  }

  _onRemoveItem(CartRemoveItemEvent event, Emitter emit) async {
    await _cartRepository.removeItemFromCart(event.itemID).then((value) {
      Fluttertoast.showToast(msg: 'Xóa sản phẩm thành công');
    });
  }

  _onItemSelected(CartItemSelectedEvent event, Emitter emit) {
    List<CartItemModel> temp = List.from(state.selectedCartitems);
    bool check = state.selectedCartitems.contains(event.item);

    if (check) {
      temp.remove(event.item);
    } else {
      temp.add(event.item);
    }

    emit(
      state.copyWith(
        selectedCartitems: temp,
        isAllSelected: temp.length == state.cartItems.length,
      ),
    );
  }

  _onAddItem(CartAddItemEvent event, Emitter emit) async {
    await _cartRepository.addItemToCart(event.itemID).then((value) {
      Fluttertoast.showToast(msg: 'Đã thêm vào giỏ hàng');
    });
  }

  _onUpdate(CartUpdateEvent event, Emitter emit) {
    emit(state.copyWith(
      cartItems: event.listCart,
      selectedCartitems: [],
      isAllSelected: false,
      isLoading: false,
    ));
  }

  _onUpdateEmpty(CartUpdateEmptyEvent event, Emitter emit) {
    emit(
      state.copyWith(
        isLoading: false,
        selectedCartitems: [],
        isAllSelected: true,
        cartItems: [],
      ),
    );
  }
}
