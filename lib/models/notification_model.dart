import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final bool isRead;
  final String actionCode;

  NotificationModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.isRead,
    required this.actionCode,
  });

  factory NotificationModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Timestamp dateNoti = snapshot.get('date');
    return NotificationModel(
      id: snapshot.id,
      title: snapshot.get('title'),
      content: snapshot.get('content'),
      date: dateNoti.toDate(),
      isRead: snapshot.get('isRead'),
      actionCode: snapshot.get('actionCode'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'date': date,
      'isRead': isRead,
      'actionCode': actionCode,
    };
  }
}
