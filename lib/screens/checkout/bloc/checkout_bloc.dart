import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:book_store/models/address_model.dart';
import 'package:book_store/models/create_order_response.dart';
import 'package:book_store/models/notification_model.dart';
import 'package:book_store/models/payment_method_model.dart';
import 'package:book_store/models/transaction_model.dart';
import 'package:book_store/models/transport_model.dart';
import 'package:book_store/utils/zalopay_app_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  static const MethodChannel platform =
      MethodChannel('flutter.native/channelPayOrder');

  CheckoutBloc() : super(CheckoutLoadingState()) {
    on<CheckoutLoadingEvent>(checkoutLoadingEvent);
    on<CheckoutUpdateEmptyAddressEvent>(checkoutUpdateEmptyAddressEvent);
    on<CheckoutUpdateAddressEvent>(checkoutUpdateAddressEvent);
    on<CheckoutSimpleOrderEvent>(checkoutOrderEvent);
    on<CheckoutZaloPayOrderEvent>(checkoutZaloPayOrderEvent);
    on<CheckoutUpdatePaymentMethodEvent>(checkoutUpdatePaymentMethodEvent);
    on<CheckoutUpdateTransportEvent>(checkoutUpdateTransportEvent);
  }

  FutureOr<void> checkoutLoadingEvent(
      CheckoutLoadingEvent event, Emitter<CheckoutState> emit) {
    emit(CheckoutLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .snapshots()
        .listen((firebaseEvent) async {
      if (firebaseEvent.exists) {
        AddressModel userAddress;

        final addressCodeQuery =
            await FirebaseFirestore.instance.collection('User').doc(uid).get();

        String addressCode =
            await addressCodeQuery.data()!['defaultAddress'] ?? '';

        if (addressCode == '') {
          userAddress = const AddressModel(
              id: '', name: '', phone: '', address: '', isDefault: false);
        } else {
          final addressQuery = await FirebaseFirestore.instance
              .collection('User')
              .doc(uid)
              .collection('Address')
              .doc(addressCode)
              .get();
          userAddress = AddressModel.fromSnapshot(addressQuery, true);
        }

        add(CheckoutUpdateAddressEvent(
          newAddress: userAddress,
        ));
      } else {
        List<TransportModel> transports = [];

        final transportQuery =
            await FirebaseFirestore.instance.collection('Transport').get();
        for (int i = 0; i < transportQuery.size; i++) {
          if (i == 0) {
            transports
                .add(TransportModel.fromSnapshot(transportQuery.docs[i], true));
          } else {
            transports.add(
                TransportModel.fromSnapshot(transportQuery.docs[i], false));
          }
        }
        add(CheckoutUpdateEmptyAddressEvent(transports: transports));
      }
    });
  }

  FutureOr<void> checkoutUpdateAddressEvent(
      CheckoutUpdateAddressEvent event, Emitter<CheckoutState> emit) async {
    if (state is CheckoutLoadingState) {
      List<TransportModel> transports = [];
      List<PaymentMethodModel> payments =
          List.from(PaymentMethodModel.listPayment);

      final transportQuery =
          await FirebaseFirestore.instance.collection('Transport').get();
      for (int i = 0; i < transportQuery.size; i++) {
        if (i == 0) {
          transports
              .add(TransportModel.fromSnapshot(transportQuery.docs[i], true));
        } else {
          transports
              .add(TransportModel.fromSnapshot(transportQuery.docs[i], false));
        }
      }

      emit(CheckoutLoadingSuccessfulState(
        userAddress: event.newAddress,
        transports: transports,
        payments: payments,
        showLoadingDialog: false,
      ));
    } else if (state is CheckoutLoadingSuccessfulState) {
      final currentState = state as CheckoutLoadingSuccessfulState;

      emit(CheckoutLoadingSuccessfulState(
        userAddress: event.newAddress,
        transports: currentState.transports,
        payments: currentState.payments,
        showLoadingDialog: false,
      ));
    } else if (state is CheckoutEmptyAddressState) {
      final currentState = state as CheckoutEmptyAddressState;

      emit(CheckoutLoadingSuccessfulState(
        userAddress: event.newAddress,
        transports: currentState.transports,
        payments: currentState.payments,
        showLoadingDialog: false,
      ));
    }
  }

  FutureOr<void> checkoutUpdateEmptyAddressEvent(
      CheckoutUpdateEmptyAddressEvent event, Emitter<CheckoutState> emit) {
    List<PaymentMethodModel> payments =
        List.from(PaymentMethodModel.listPayment);
    emit(CheckoutEmptyAddressState(
      transports: event.transports,
      payments: payments,
      showLoadingDialog: false,
    ));
  }

  FutureOr<void> checkoutOrderEvent(
      CheckoutSimpleOrderEvent event, Emitter<CheckoutState> emit) async {
    if (state is CheckoutLoadingSuccessfulState) {
      final currentState = state as CheckoutLoadingSuccessfulState;
      emit(
        CheckoutLoadingSuccessfulState(
          userAddress: currentState.userAddress,
          transports: currentState.transports,
          payments: currentState.payments,
          showLoadingDialog: true,
        ),
      );

      String uid = FirebaseAuth.instance.currentUser!.uid;

      try {
        final transactionCollection = FirebaseFirestore.instance
            .collection('User')
            .doc(uid)
            .collection('Transaction');

        await transactionCollection
            .add(event.transaction.toJson())
            .then((value) async {
          for (var ele in event.transaction.products) {
            await FirebaseFirestore.instance
                .collection('User')
                .doc(uid)
                .collection('Transaction')
                .doc(value.id)
                .collection('Products')
                .add(ele.toJson());
          }

          await FirebaseFirestore.instance
              .collection('User')
              .doc(uid)
              .collection('Notification')
              .add(createNotification(value.id).toJson());

          if (event.fromCart) {
            final cartCollection = FirebaseFirestore.instance
                .collection('User')
                .doc(uid)
                .collection('Cart');
            for (var ele in event.transaction.products) {
              await cartCollection.doc(ele.id).delete();
            }
          }

          emit(CheckoutOrderSuccessfulState(idTransaction: value.id));
        });
      } on FirebaseException catch (e) {
        emit(
          CheckoutLoadingSuccessfulState(
            userAddress: currentState.userAddress,
            transports: currentState.transports,
            payments: currentState.payments,
            showLoadingDialog: false,
          ),
        );
        Fluttertoast.showToast(msg: "Error: ${e.message}");
      }
    } else if (state is CheckoutEmptyAddressState) {
      Fluttertoast.showToast(msg: 'Vui lòng cung cấp địa chỉ giao hàng');
    }
  }

  FutureOr<void> checkoutZaloPayOrderEvent(
      CheckoutZaloPayOrderEvent event, Emitter<CheckoutState> emit) async {
    if (state is CheckoutLoadingSuccessfulState) {
      final currentState = state as CheckoutLoadingSuccessfulState;
      emit(
        CheckoutLoadingSuccessfulState(
          userAddress: currentState.userAddress,
          transports: currentState.transports,
          payments: currentState.payments,
          showLoadingDialog: true,
        ),
      );

      var createOrderResult =
          await createOrder(event.transaction.totalPrice.toInt());
      if (createOrderResult != null) {
        final String result = await platform.invokeMethod(
            'payOrder', {"zptoken": createOrderResult.zptranstoken});
        if (result == 'Payment Success') {
          String uid = FirebaseAuth.instance.currentUser!.uid;
          try {
            final transactionCollection = FirebaseFirestore.instance
                .collection('User')
                .doc(uid)
                .collection('Transaction');

            await transactionCollection
                .add(event.transaction.toJson())
                .then((value) async {
              for (var ele in event.transaction.products) {
                await FirebaseFirestore.instance
                    .collection('User')
                    .doc(uid)
                    .collection('Transaction')
                    .doc(value.id)
                    .collection('Products')
                    .add(ele.toJson());
              }
              await FirebaseFirestore.instance
                  .collection('User')
                  .doc(uid)
                  .collection('Notification')
                  .add(createNotification(value.id).toJson());

              if (event.fromCart) {
                final cartCollection = FirebaseFirestore.instance
                    .collection('User')
                    .doc(uid)
                    .collection('Cart');
                for (var ele in event.transaction.products) {
                  await cartCollection.doc(ele.id).delete();
                }
              }

              emit(CheckoutOrderSuccessfulState(idTransaction: value.id));
            });
          } on FirebaseException catch (e) {
            emit(
              CheckoutLoadingSuccessfulState(
                userAddress: currentState.userAddress,
                transports: currentState.transports,
                payments: currentState.payments,
                showLoadingDialog: false,
              ),
            );
            Fluttertoast.showToast(msg: "Error: ${e.message}");
          }
        } else {
          switch (result) {
            case 'User Canceled':
              emit(
                CheckoutLoadingSuccessfulState(
                  userAddress: currentState.userAddress,
                  transports: currentState.transports,
                  payments: currentState.payments,
                  showLoadingDialog: false,
                ),
              );
              Fluttertoast.showToast(msg: "Thanh toán bị hủy");
              break;
            case 'Payment failed':
              emit(
                CheckoutLoadingSuccessfulState(
                  userAddress: currentState.userAddress,
                  transports: currentState.transports,
                  payments: currentState.payments,
                  showLoadingDialog: false,
                ),
              );
              Fluttertoast.showToast(msg: "Lỗi thanh toán");
              break;
          }
        }
      } else {
        emit(
          CheckoutLoadingSuccessfulState(
            userAddress: currentState.userAddress,
            transports: currentState.transports,
            payments: currentState.payments,
            showLoadingDialog: false,
          ),
        );
        Fluttertoast.showToast(msg: "Lỗi không xác định");
      }
    } else if (state is CheckoutEmptyAddressState) {
      Fluttertoast.showToast(msg: 'Vui lòng cung cấp địa chỉ giao hàng');
    }
  }

  NotificationModel createNotification(String checkOutID) {
    return NotificationModel(
      id: '',
      title: 'Đặt hàng thành công',
      content:
          'Yêu cầu của đơn hàng $checkOutID đã được gửi đến cho người bán. Bạn có thể theo dõi trạng thái đơn hàng ở trong mục Đơn hàng của tôi.',
      date: DateTime.now(),
      isRead: false,
      actionCode: 'order_0',
    );
  }

  Future<CreateOrderResponse?> createOrder(int price) async {
    var header = <String, String>{};
    header["Content-Type"] = "application/x-www-form-urlencoded";

    var body = <String, String>{};
    body["app_id"] = ZaloAppConfig.appId;
    body["app_user"] = ZaloAppConfig.appName;
    body["app_time"] = DateTime.now().millisecondsSinceEpoch.toString();
    body["amount"] = price.toStringAsFixed(0);
    body["app_trans_id"] =
        DateFormat('yyMMdd_hhmmss').format(DateTime.now()).toString();
    body["embed_data"] = "{}";
    body["item"] = "[]";
    body["bank_code"] = "zalopayapp";
    body["description"] = getDescription(body["app_trans_id"]);

    var dataGetMac =
        '${body["app_id"]}|${body["app_trans_id"]}|${body["app_user"]}|${body["amount"]}|${body["app_time"]}|${body["embed_data"]}|${body["item"]}';
    body["mac"] = getMacCreateOrder(dataGetMac);

    http.Response response = await http.post(
      Uri.parse(Uri.encodeFull(ZaloAppConfig.createOrderUrl)),
      headers: header,
      body: body,
    );

    if (response.statusCode != 200) {
      return null;
    }

    var data = jsonDecode(response.body);

    return CreateOrderResponse.fromJson(data);
  }

  String getDescription(String? body) => "IBOO thanh toán cho đơn hàng  #$body";

  String getMacCreateOrder(String dataGetMac) {
    var hmac = Hmac(sha256, utf8.encode(ZaloAppConfig.key1));
    return hmac.convert(utf8.encode(dataGetMac)).toString();
  }

  FutureOr<void> checkoutUpdatePaymentMethodEvent(
      CheckoutUpdatePaymentMethodEvent event, Emitter<CheckoutState> emit) {
    if (state is CheckoutLoadingSuccessfulState) {
      final currentState = state as CheckoutLoadingSuccessfulState;

      emit(CheckoutLoadingSuccessfulState(
        userAddress: currentState.userAddress,
        transports: currentState.transports,
        payments: event.payment,
        showLoadingDialog: false,
      ));
    }
  }

  FutureOr<void> checkoutUpdateTransportEvent(
      CheckoutUpdateTransportEvent event, Emitter<CheckoutState> emit) {
    if (state is CheckoutLoadingSuccessfulState) {
      final currentState = state as CheckoutLoadingSuccessfulState;

      emit(CheckoutLoadingSuccessfulState(
        userAddress: currentState.userAddress,
        transports: event.transport,
        payments: currentState.payments,
        showLoadingDialog: false,
      ));
    }
  }
}
