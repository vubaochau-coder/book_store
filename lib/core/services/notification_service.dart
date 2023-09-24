import 'package:book_store/core/constant/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/notification_model.dart';

class NotificationService {
  Future<void> createCancelTransactionNoti(String transId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final model = NotificationModel(
      id: '',
      title: 'Đơn hàng đã bị hủy',
      content:
          'Đơn hàng $transId của bạn đã bị hủy. Bạn có thể mua lại các sản phẩm trong đơn hàng bất kỳ lúc nào trong mục "Đơn hàng của tôi" - "Đã hủy".',
      date: DateTime.now(),
      isRead: false,
      actionCode: 'order_-1',
    );

    await FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.notification)
        .add(model.toJson());
  }

  Future<void> createReceiveTransactionNoti(String transId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final model = NotificationModel(
      id: '',
      title: 'Giao hàng thành công',
      content:
          'Đơn hàng $transId của bạn đã được giao thành công. Hãy sớm cho chúng tôi biết cảm nhận của bạn sau khi trải nghiệm sản phẩm nhé!',
      date: DateTime.now(),
      isRead: false,
      actionCode: 'order_3',
    );

    await FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.notification)
        .add(model.toJson());
  }
}
