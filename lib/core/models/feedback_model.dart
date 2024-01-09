import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  final String id;
  final String bookID;
  final String review;
  final String userName;
  final String userImg;
  final DateTime dateSubmit;
  final double rating;
  final bool isReply;
  final bool isLike;
  final String adminReply;

  FeedbackModel({
    required this.id,
    required this.bookID,
    required this.review,
    required this.userName,
    required this.userImg,
    required this.dateSubmit,
    required this.rating,
    required this.isLike,
    required this.isReply,
    required this.adminReply,
  });

  factory FeedbackModel.fromSnaphot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Timestamp temp = snapshot.get('dateSubmit');
    return FeedbackModel(
      id: snapshot.id,
      bookID: snapshot.get('bookID'),
      review: snapshot.get('review'),
      userName: snapshot.get('user'),
      userImg: snapshot.get('userImg'),
      dateSubmit: temp.toDate(),
      rating: double.parse(snapshot.get('rating').toString()),
      isLike: snapshot.get('isLiked'),
      isReply: snapshot.get('isReply'),
      adminReply: snapshot.get('adminReply'),
    );
  }
}
