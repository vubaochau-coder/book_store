import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class VerticalNavigationBar extends StatefulWidget {
  const VerticalNavigationBar({
    super.key,
    required this.items,
    required this.selectedIndex,
  });

  final int selectedIndex;
  final List<VerticalNavigationBarItem> items;

  @override
  State<VerticalNavigationBar> createState() => _VerticalNavigationBarState();
}

class _VerticalNavigationBarState extends State<VerticalNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class VerticalNavigationBarItem extends StatelessWidget {
  const VerticalNavigationBarItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            top: 60,
            curve: Curves.ease,
            child: Container(
              height: 60,
              width: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: themeColor,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [],
          )
        ],
      ),
    );
  }
}
