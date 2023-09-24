import 'package:cloud_firestore/cloud_firestore.dart';

class SearchSuggestionModel {
  final String id;
  final String query;
  final DateTime date;

  SearchSuggestionModel({
    required this.id,
    required this.query,
    required this.date,
  });

  factory SearchSuggestionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Timestamp temp = snapshot.get('date');
    return SearchSuggestionModel(
      id: snapshot.id,
      query: snapshot.get('query'),
      date: temp.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'date': date,
    };
  }
}
