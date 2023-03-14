import 'package:flutter/material.dart';

class CategoriesMenu extends StatelessWidget {
  const CategoriesMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        categoryItem(
          'images/Category/textbook.png',
          'Sách giáo khoa',
          const Color.fromRGBO(255, 238, 88, 1),
        ),
        categoryItem(
          'images/Category/book.png',
          'Tiểu thuyết',
          const Color.fromRGBO(171, 71, 188, 1),
        ),
        categoryItem(
          'images/Category/comic.png',
          'Truyện tranh',
          const Color.fromRGBO(129, 199, 132, 1),
        ),
        categoryItem(
          'images/Category/bookchild.png',
          'Trẻ em',
          const Color.fromRGBO(236, 64, 122, 1),
        ),
        categoryItem(
          'images/Category/science.png',
          'Khoa học',
          const Color.fromRGBO(239, 83, 80, 1),
        ),
        categoryItem(
          'images/Category/world-book-day.png',
          'Khác',
          const Color.fromRGBO(66, 165, 245, 1),
        ),
      ],
    );
  }

  Widget categoryItem(String imgPath, String text, Color color) {
    return SizedBox(
      width: 44,
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            elevation: 2,
            child: Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: SizedBox(
                height: 28,
                width: 28,
                child: Image.asset(
                  imgPath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
