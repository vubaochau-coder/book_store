import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/models/cart_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoadingState()) {
    on<CartLoadingEvent>(cartLoadingEvent);
    on<CartAllItemSelectedEvent>(cartAllItemSelectedEvent);
    on<CartChangeItemQuantityEvent>(cartChangeItemQuantityEvent);
    on<CartRemoveItemEvent>(cartRemoveItemEvent);
    on<CartItemSelectedEvent>(cartItemSelectedEvent);
    on<CartAddItemEvent>(cartAddItemEvent);
    on<CartUpdateEvent>(cartUpdateEvent);
    on<CartUpdateEmptyEvent>(cartUpdateEmptyEvent);
  }

  FutureOr<void> cartLoadingEvent(
      CartLoadingEvent event, Emitter<CartState> emit) async {
    // if (state is! CartLoadingSuccessfulState) {

    // }
    emit(CartLoadingState());

    String userID = FirebaseAuth.instance.currentUser!.uid;
    // List<CartItemModel> cartDatas = [];

    // final cartQuery = await FirebaseFirestore.instance
    //     .collection('User')
    //     .doc(userID)
    //     .collection('Cart')
    //     .get();
    // for (var ele in cartQuery.docs) {
    //   String bookID = ele.get('productID');
    //   final bookQuery =
    //       await FirebaseFirestore.instance.collection('Book').doc(bookID).get();

    //   String bookTitle = bookQuery.get('title');
    //   double bookPrice = double.parse(bookQuery.get('price').toString());
    //   double bookDiscount = double.parse(bookQuery.get('discount').toString());
    //   String url = List.from(bookQuery.get('listURL'))[0];

    //   cartDatas.add(CartItemModel.fromSnapshot(ele,
    //       (bookPrice - bookPrice * bookDiscount), bookPrice, url, bookTitle));
    // }

    // emit(CartLoadingSuccessfulState(cartItems: cartDatas));

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

  FutureOr<void> cartAllItemSelectedEvent(
      CartAllItemSelectedEvent event, Emitter<CartState> emit) {
    List<CartItemModel> temp = [];
    if (isAllItemSelected(event.listCart)) {
      for (var ele in event.listCart) {
        CartItemModel model = CartItemModel(
            id: ele.id,
            bookID: ele.bookID,
            count: ele.count,
            price: ele.price,
            imgUrl: ele.imgUrl,
            title: ele.title,
            isSelected: false,
            priceBeforeDiscount: ele.priceBeforeDiscount);
        temp.add(model);
      }
    } else {
      for (var ele in event.listCart) {
        CartItemModel model = CartItemModel(
            id: ele.id,
            bookID: ele.bookID,
            count: ele.count,
            price: ele.price,
            imgUrl: ele.imgUrl,
            title: ele.title,
            isSelected: true,
            priceBeforeDiscount: ele.priceBeforeDiscount);
        temp.add(model);
      }
    }
    emit(CartLoadingSuccessfulState(cartItems: temp));
  }

  FutureOr<void> cartChangeItemQuantityEvent(
      CartChangeItemQuantityEvent event, Emitter<CartState> emit) {
    List<CartItemModel> temp = [];
    for (var ele in event.listCart) {
      if (ele.id == event.itemID) {
        CartItemModel model = CartItemModel(
            id: ele.id,
            bookID: ele.bookID,
            count: event.isIncrease ? ele.count + 1 : ele.count - 1,
            price: ele.price,
            imgUrl: ele.imgUrl,
            title: ele.title,
            isSelected: ele.isSelected,
            priceBeforeDiscount: ele.priceBeforeDiscount);
        temp.add(model);
      } else {
        temp.add(ele);
      }
    }
    emit(CartLoadingSuccessfulState(cartItems: temp));
  }

  FutureOr<void> cartRemoveItemEvent(
      CartRemoveItemEvent event, Emitter<CartState> emit) async {
    final String userID = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance
        .collection('User')
        .doc(userID)
        .collection('Cart')
        .doc(event.itemID);
    await docRef
        .delete()
        .then((value) => Fluttertoast.showToast(msg: 'Xóa sản phẩm thành công'))
        .catchError((err) => Fluttertoast.showToast(
              msg: err.toString(),
            ));
  }

  FutureOr<void> cartItemSelectedEvent(
      CartItemSelectedEvent event, Emitter<CartState> emit) {
    List<CartItemModel> temp = [];
    for (var ele in event.listCart) {
      if (ele.id == event.itemID) {
        CartItemModel model = CartItemModel(
            id: ele.id,
            bookID: ele.bookID,
            count: ele.count,
            price: ele.price,
            imgUrl: ele.imgUrl,
            title: ele.title,
            isSelected: !ele.isSelected,
            priceBeforeDiscount: ele.priceBeforeDiscount);
        temp.add(model);
      } else {
        temp.add(ele);
      }
    }
    emit(CartLoadingSuccessfulState(cartItems: temp));
  }

  bool isAllItemSelected(List<CartItemModel> list) {
    for (var ele in list) {
      if (ele.isSelected == false) {
        return false;
      }
    }
    return true;
  }

  FutureOr<void> cartAddItemEvent(
      CartAddItemEvent event, Emitter<CartState> emit) async {
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
              'temp': ['1', '2', '3']
            });
          }
        })
        .then(
            (value) => Fluttertoast.showToast(msg: 'Thêm sản phẩm thành công'))
        .catchError(
          (err) => Fluttertoast.showToast(
            msg: err.toString(),
          ),
        );
  }

  FutureOr<void> cartUpdateEvent(
      CartUpdateEvent event, Emitter<CartState> emit) {
    if (state is CartLoadingState) {
      emit(CartLoadingSuccessfulState(cartItems: event.listCart));
    } else if (state is CartLoadingSuccessfulState) {
      final currentSate = state as CartLoadingSuccessfulState;

      List<CartItemModel> temp = [];

      if (currentSate.cartItems.isNotEmpty) {
        currentSate.cartItems.clear();
      }

      temp.addAll(event.listCart);

      emit(CartLoadingSuccessfulState(cartItems: temp));
    } else if (state is CartEmptyState) {
      List<CartItemModel> temp = [];

      temp.addAll(event.listCart);

      emit(CartLoadingSuccessfulState(cartItems: temp));
    }
  }

  FutureOr<void> cartUpdateEmptyEvent(
      CartUpdateEmptyEvent event, Emitter<CartState> emit) {
    emit(CartEmptyState());
  }
}
