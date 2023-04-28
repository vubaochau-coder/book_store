import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class ChoBanPage extends StatefulWidget {
  final int index;
  const ChoBanPage({super.key, required this.index});

  @override
  State<ChoBanPage> createState() => _ChoBanPageState();
}

class _ChoBanPageState extends State<ChoBanPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 6,
      vsync: this,
      initialIndex: widget.index,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: const Text('Danh mục sản phẩm'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: themeColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: SafeArea(
              child: Container(
                color: Colors.grey[200],
                child: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey[400],
                  labelColor: Colors.white,
                  indicator: BoxDecoration(
                    color: themeColor,
                  ),
                  // onTap: (value) {
                  //   setState(() {
                  //     selectedIndex = value;
                  //   });
                  // },
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  tabs: [
                    myTab('images/Category/textbook.png', "S. Giáo khoa"),
                    myTab('images/Category/book.png', 'Tiểu thuyết'),
                    myTab('images/Category/comic.png', "Truyện tranh"),
                    myTab('images/Category/bookchild.png', "Trẻ em"),
                    myTab('images/Category/science.png', 'Khoa học'),
                    myTab('images/Category/world-book-day.png', "Khác"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget myTab(String img, String text) {
    return Container(
      width: 98,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Tab(
        height: 60,
        icon: Image.asset(
          img,
          height: 32,
          fit: BoxFit.contain,
        ),
        text: text,
      ),
    );
  }
}
