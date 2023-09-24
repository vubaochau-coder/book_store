import 'package:book_store/custom_widgets/custom_page_route.dart';
import 'package:book_store/models/category_model.dart';
import 'package:book_store/screens/categories/category_page.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

import 'category_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(6),
          radius: 6,
          onTap: () => Future.delayed(
            Duration(milliseconds: delay),
            () => Navigator.of(context).push(
              PageRouteSlideTransition(
                child: const CategoryPage(index: 0),
              ),
            ),
          ),
          child: CategorieItem(
            categoryData: Category.categories[0],
          ),
        ),
        InkWell(
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(6),
          radius: 6,
          onTap: () => Future.delayed(
            Duration(milliseconds: delay),
            () => Navigator.of(context).push(
              PageRouteSlideTransition(
                child: const CategoryPage(index: 1),
              ),
            ),
          ),
          child: CategorieItem(
            categoryData: Category.categories[1],
          ),
        ),
        InkWell(
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(6),
          radius: 6,
          onTap: () => Future.delayed(
            Duration(milliseconds: delay),
            () => Navigator.of(context).push(
              PageRouteSlideTransition(
                child: const CategoryPage(index: 2),
              ),
            ),
          ),
          child: CategorieItem(
            categoryData: Category.categories[2],
          ),
        ),
        InkWell(
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(6),
          radius: 6,
          onTap: () => Future.delayed(
            Duration(milliseconds: delay),
            () => Navigator.of(context).push(
              PageRouteSlideTransition(
                child: const CategoryPage(index: 3),
              ),
            ),
          ),
          child: CategorieItem(
            categoryData: Category.categories[3],
          ),
        ),
        InkWell(
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(6),
          radius: 6,
          onTap: () => Future.delayed(
            Duration(milliseconds: delay),
            () => Navigator.of(context).push(
              PageRouteSlideTransition(
                child: const CategoryPage(index: 4),
              ),
            ),
          ),
          child: CategorieItem(
            categoryData: Category.categories[4],
          ),
        ),
        InkWell(
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(6),
          radius: 6,
          onTap: () => Future.delayed(
            Duration(milliseconds: delay),
            () => Navigator.of(context).push(
              PageRouteSlideTransition(
                child: const CategoryPage(index: 5),
              ),
            ),
          ),
          child: CategorieItem(
            categoryData: Category.categories[5],
          ),
        ),
      ],
    );
  }
}
