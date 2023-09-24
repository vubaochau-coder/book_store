import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';

class Category extends Equatable {
  final String text;
  final String imgPath;
  final Color color;

  const Category({
    required this.text,
    required this.imgPath,
    required this.color,
  });

  @override
  List<Object?> get props => [text, imgPath, color];

  static List<Category> categories = const [
    Category(
      text: 'SGK',
      imgPath: 'images/Category/textbook.png',
      color: Color.fromRGBO(255, 238, 88, 1),
    ),
    Category(
      imgPath: 'images/Category/book.png',
      text: 'Văn học',
      color: Color.fromRGBO(171, 71, 188, 1),
    ),
    Category(
      imgPath: 'images/Category/comic.png',
      text: 'Truyện',
      color: Color.fromRGBO(129, 199, 132, 1),
    ),
    Category(
      imgPath: 'images/Category/bookchild.png',
      text: 'Trẻ em',
      color: Color.fromRGBO(236, 64, 122, 1),
    ),
    Category(
      imgPath: 'images/Category/science.png',
      text: 'KH-KT',
      color: Color.fromRGBO(239, 83, 80, 1),
    ),
    Category(
      imgPath: 'images/Category/world-book-day.png',
      text: 'Khác',
      color: Color.fromRGBO(66, 165, 245, 1),
    ),
  ];
}
