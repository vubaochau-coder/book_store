import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/cart_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartLoadingEvent>(_onLoading);
    on<CartAllItemSelectedEvent>(_onAllItemSelected);
    on<CartChangeItemQuantityEvent>(_onChangeItemQuantity);
    on<CartRemoveItemEvent>(_onRemoveItem);
    on<CartItemSelectedEvent>(_onItemSelected);
    on<CartAddItemEvent>(_onAddItem);
    on<CartUpdateEvent>(_onUpdate);
    on<CartUpdateEmptyEvent>(_onUpdateEmpty);
  }

  _onLoading(CartLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    String userID = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('User')
        .doc(userID)
        .collection('Cart')
        .snapshots()
        .listen((event) async {
      if (event.docs.isNotEmpty) {
        List<CartItemModel> cartDatas = [];
        for (var ele in event.docs) {
          String bookID = ele.get('productID');
          final bookQuery = await FirebaseFirestore.instance
              .collection('Book')
              .doc(bookID)
              .get();

          String bookTitle = bookQuery.get('title');
          double bookPrice = double.parse(bookQuery.get('price').toString());
          double bookDiscount =
              double.parse(bookQuery.get('discount').toString());
          String url = List.from(bookQuery.get('listURL'))[0];

          cartDatas.add(CartItemModel.fromSnapshot(
              ele,
              (bookPrice - bookPrice * bookDiscount),
              bookPrice,
              url,
              bookTitle));
        }
        add(CartUpdateEvent(listCart: cartDatas));
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
    final String userID = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance
        .collection('User')
        .doc(userID)
        .collection('Cart')
        .doc(event.itemID);
    await docRef
        .delete()
        .then((value) => Fluttertoast.showToast(msg: 'Xóa sản phẩm thành công'))
        .catchError(
          (err) => Fluttertoast.showToast(
            msg: err.toString(),
          ),
        );
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
    String userID = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance
        .collection('User')
        .doc(userID)
        .collection('Cart')
        .where('productID', isEqualTo: event.itemID);
    docRef
        .get()
        .then((value) async {
          if (value.size == 0) {
            await FirebaseFirestore.instance
                .collection('User')
                .doc(userID)
                .collection('Cart')
                .add({
              'productID': event.itemID,
              'count': 1,
            });
          }
        })
        .then((value) => Fluttertoast.showToast(msg: 'Đã thêm vào giỏ hàng'))
        .catchError(
          (err) => Fluttertoast.showToast(
            msg: err.toString(),
          ),
        );
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
