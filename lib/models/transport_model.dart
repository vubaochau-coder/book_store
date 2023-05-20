import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TransportModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final bool isSelected;

  const TransportModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.isSelected,
  });

  factory TransportModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot, bool isSelected) {
    return TransportModel(
      id: snapshot.id,
      name: snapshot.data()!['name'],
      description: snapshot.data()!['description'],
      price: double.parse(snapshot.data()!['price'].toString()),
      isSelected: isSelected,
    );
  }

  @override
  List<Object?> get props => [id, name, description, price, isSelected];
}
