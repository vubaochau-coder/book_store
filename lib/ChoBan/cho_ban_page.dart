import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class ChoBanPage extends StatefulWidget {
  const ChoBanPage({super.key});

  @override
  State<ChoBanPage> createState() => _ChoBanPageState();
}

class _ChoBanPageState extends State<ChoBanPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              backgroundColor: Colors.white,
              elevation: 1,
              labelType: NavigationRailLabelType.all,
              unselectedLabelTextStyle: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
              useIndicator: true,
              indicatorColor: themeColor,
              selectedLabelTextStyle: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              minWidth: 56,
              destinations: [
                NavigationRailDestination(
                  icon: Image.asset(
                    'images/Category/textbook.png',
                    height: 32,
                  ),
                  label: const SizedBox(
                    width: 56,
                    child: Text(
                      'S. giáo khoa',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                NavigationRailDestination(
                  icon: Image.asset(
                    'images/Category/book.png',
                    height: 32,
                  ),
                  label: const SizedBox(
                    width: 56,
                    child: Text(
                      'Tiểu thuyết',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                NavigationRailDestination(
                  icon: Image.asset(
                    'images/Category/comic.png',
                    height: 32,
                  ),
                  label: const SizedBox(
                    width: 56,
                    child: Text(
                      'Truyện tranh',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                NavigationRailDestination(
                  icon: Image.asset(
                    'images/Category/bookchild.png',
                    height: 32,
                  ),
                  label: const SizedBox(
                    width: 56,
                    child: Text(
                      'Trẻ em',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                NavigationRailDestination(
                  icon: Image.asset(
                    'images/Category/science.png',
                    height: 32,
                  ),
                  label: const SizedBox(
                    width: 56,
                    child: Text(
                      'Khoa học',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                NavigationRailDestination(
                  icon: Image.asset(
                    'images/Category/world-book-day.png',
                    height: 32,
                  ),
                  label: const SizedBox(
                    width: 56,
                    child: Text(
                      'Khác',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
