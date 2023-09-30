import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/notification_service.dart';

class NotificationRepository {
  late NotificationService _service;

  NotificationRepository() {
    _service = NotificationService();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamUserNoti() {
    return _service.streamUserNoti();
  }

  Future<void> readNotiEvent(String notiId) async {
    return await _service.readNotiEvent(notiId);
  }

  Future<void> readAllNotiEvent() async {
    return await _service.readAllNotiEvent();
  }

  Future<void> createCancelTransactionNoti(String transId) async {
    return await _service.createCancelTransactionNoti(transId);
  }

  Future<void> createReceiveTransactionNoti(String transId) async {
    return await _service.createReceiveTransactionNoti(transId);
  }
}
