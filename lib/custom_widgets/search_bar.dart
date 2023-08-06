import 'package:book_store/custom_widgets/custom_page_route.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

import '../screens/search/ui/search_page.dart';

class MyCustomSearchBar extends StatelessWidget {
  const MyCustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteSlideTransition(
            child: const SearchPage(),
          ),
        );
      },
      child: SizedBox(
        height: 36,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(
            left: 8,
          ),
          child: Row(
            children: [
              const SizedBox(width: 4),
              Icon(
                Icons.search,
                color: themeColor,
              ),
              const SizedBox(width: 12),
              const Text(
                'Tìm kiếm sản phẩm',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Container(
                width: 58,
                height: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 2,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffe65728),
                      Color(0xffffe341),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: const Text(
                  'Tìm',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
