import 'package:cloud_firestore/cloud_firestore.dart';

class AdvertisingDataModel {
  final String id;
  final String dateEnd;
  final String imgURL;

  AdvertisingDataModel({
    required this.id,
    required this.dateEnd,
    required this.imgURL,
  });

  factory AdvertisingDataModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return AdvertisingDataModel(
      dateEnd: data['dateCompleted'],
      imgURL: data['url'],
      id: documentSnapshot.id,
    );
  }
}
