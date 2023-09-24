import '../services/notification_service.dart';

class NotificationRepository {
  late NotificationService _service;

  NotificationRepository() {
    _service = NotificationService();
  }

  Future<void> createCancelTransactionNoti(String transId) async {
    return await _service.createCancelTransactionNoti(transId);
  }

  Future<void> createReceiveTransactionNoti(String transId) async {
    return await _service.createReceiveTransactionNoti(transId);
  }
}
