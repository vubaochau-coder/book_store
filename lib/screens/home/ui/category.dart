import 'package:book_store/models/category_model.dart';
import 'package:flutter/material.dart';

class CategorieItem extends StatelessWidget {
  final Category categoryData;
  const CategorieItem({super.key, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      //margin: const EdgeInsets.symmetric(horizontal: 6),
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
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: categoryData.color,
              ),
              child: SizedBox(
                height: 28,
                width: 28,
                child: Image.asset(
                  categoryData.imgPath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Text(
            categoryData.text,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
