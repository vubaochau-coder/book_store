import 'package:book_store/Category/ChildCategory/bloc/child_bloc.dart';
import 'package:book_store/Category/ChildCategory/ui/child_category_page.dart';
import 'package:book_store/Category/ComicCategory/bloc/comic_bloc.dart';
import 'package:book_store/Category/ComicCategory/ui/comic_category_page.dart';
import 'package:book_store/Category/LiteratureCategory/bloc/literature_bloc.dart';
import 'package:book_store/Category/LiteratureCategory/ui/literature_category_page.dart';
import 'package:book_store/Category/OtherCategory/bloc/other_bloc.dart';
import 'package:book_store/Category/OtherCategory/ui/other_category_page.dart';
import 'package:book_store/Category/SGKCategory/bloc/sgk_bloc.dart';
import 'package:book_store/Category/SGKCategory/ui/sgk_category_page.dart';
import 'package:book_store/Category/ScienceCategory/bloc/science_bloc.dart';
import 'package:book_store/Category/ScienceCategory/ui/science_category_page.dart';
import 'package:book_store/CustomWidget/search_bar.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatefulWidget {
  final int index;
  const CategoryPage({super.key, required this.index});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
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

    BlocProvider.of<SgkBloc>(context).add(const SgkLoadEvent(options: 0));
    BlocProvider.of<LiteratureBloc>(context)
        .add(const LiteratureLoadEvent(options: 0));
    BlocProvider.of<ComicBloc>(context).add(const ComicLoadEvent(options: 0));
    BlocProvider.of<ChildBloc>(context).add(const ChildLoadEvent(options: 0));
    BlocProvider.of<ScienceBloc>(context)
        .add(const ScicenceLoadEvent(options: 0));
    BlocProvider.of<OtherBloc>(context).add(const OtherLoadEvent(options: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        leadingWidth: 62,
        backgroundColor: themeColor,
        title: const MyCustomSearchBar(),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                child: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey[400],
                  labelColor: themeColor,
                  indicator: BoxDecoration(
                    color: themeColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(6),
                    // border: Border.all(
                    //   color: themeColor,
                    //   width: 2,
                    // ),
                  ),
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  tabs: [
                    myTab('images/Category/textbook.png', "S. Giáo khoa"),
                    myTab('images/Category/book.png', 'Văn học'),
                    myTab('images/Category/comic.png', "Truyện tranh"),
                    myTab('images/Category/bookchild.png', "Trẻ em"),
                    myTab('images/Category/science.png', 'Khoa học'),
                    myTab('images/Category/world-book-day.png', "Khác"),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                SGKCategoryPage(),
                LiteratureCategoryPage(),
                ComicCategoryPage(),
                ChildCategoryPage(),
                ScienceCategoryPage(),
                OtherCategoryPage(),
              ],
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
      child: Tab(
        height: 54,
        iconMargin: const EdgeInsets.only(bottom: 4),
        icon: Image.asset(
          img,
          height: 26,
          fit: BoxFit.cover,
        ),
        text: text,
      ),
    );
  }
}
