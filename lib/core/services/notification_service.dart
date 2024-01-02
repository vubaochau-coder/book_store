import 'package:book_store/core/constant/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/notification_model.dart';

class NotificationService {
  Stream<QuerySnapshot<Map<String, dynamic>>> streamUserNoti() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.notification)
        .orderBy('date', descending: true)
        .snapshots();
  }

  Future<void> readNotiEvent(String notiId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    final notiDocRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.notification)
        .doc(notiId);
    await notiDocRef.update({'isRead': true});
  }

  Future<void> readAllNotiEvent() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    final notisQuery = await FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.notification)
        .where('isRead', isEqualTo: false)
        .get();

    await Future.wait([
      ...notisQuery.docs.map(
        (e) => e.reference.update(
          {'isRead': true},
        ),
      )
    ]);
  }

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

  Future<void> createOrderTransactionNoti(String transId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    final model = NotificationModel(
      id: '',
      title: 'Đặt hàng thành công',
      content:
          'Yêu cầu của đơn hàng $transId đã được gửi đến cho người bán. Bạn có thể theo dõi trạng thái đơn hàng ở trong mục Đơn hàng của tôi.',
      date: DateTime.now(),
      isRead: false,
      actionCode: 'order_0',
    );

    await FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.notification)
        .add(model.toJson());
  }

  Future<void> sendCreateNotiToAdmin(String transId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection(FirebaseCollections.adminNoti)
        .add({
      'date': DateTime.now(),
      'isRead': false,
      'orderId': transId,
      'status': 0,
      'type': 'order',
      'userId': uid,
    });
  }

  Future<void> sendCancelNotiToAdmin(String transId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection(FirebaseCollections.adminNoti)
        .add({
      'date': DateTime.now(),
      'isRead': false,
      'orderId': transId,
      'status': -1,
      'type': 'order',
      'userId': uid,
    });
  }

  Future<void> sendReceiveNotiToAdmin(String transId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection(FirebaseCollections.adminNoti)
        .add({
      'date': DateTime.now(),
      'isRead': false,
      'orderId': transId,
      'status': 4,
      'type': 'order',
      'userId': uid,
    });
  }
}
