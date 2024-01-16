import 'package:book_store/app_themes/app_colors.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  final String author;
  final String publisher;
  final String publishingYear;
  final String description;

  const ProductDescription({
    super.key,
    required this.author,
    required this.publisher,
    required this.publishingYear,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 14,
        right: 14,
        top: 8,
        bottom: 2,
      ),
      child: Column(
        children: [
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
            child: Table(
              children: [
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Text(
                        'Tác giả',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        author,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Text(
                        'NXB',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        publisher,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Text(
                        'Năm XB',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        publishingYear,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ExpandableText(
            description.replaceAll('\n', '\n'),
            expandText: 'Xem thêm',
            collapseText: 'Ẩn bớt',
            linkColor: AppColors.themeColor,
            maxLines: 4,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
