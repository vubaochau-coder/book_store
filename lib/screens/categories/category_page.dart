import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/core/repositories/main_repository.dart';
import 'package:book_store/custom_widgets/search_bar.dart';
import 'package:book_store/screens/categories/child/bloc/child_bloc.dart';
import 'package:book_store/screens/categories/child/ui/child_category_page.dart';
import 'package:book_store/screens/categories/comic/bloc/comic_bloc.dart';
import 'package:book_store/screens/categories/comic/ui/comic_category_page.dart';
import 'package:book_store/screens/categories/literature/bloc/literature_bloc.dart';
import 'package:book_store/screens/categories/literature/ui/literature_category_page.dart';
import 'package:book_store/screens/categories/others/bloc/other_bloc.dart';
import 'package:book_store/screens/categories/others/ui/other_category_page.dart';
import 'package:book_store/screens/categories/science/bloc/science_bloc.dart';
import 'package:book_store/screens/categories/science/ui/science_category_page.dart';
import 'package:book_store/screens/categories/sgk/bloc/sgk_bloc.dart';
import 'package:book_store/screens/categories/sgk/ui/sgk_category_page.dart';
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
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SgkBloc(
            RepositoryProvider.of<MainRepository>(context).categoryRepository,
          )..add(const SgkLoadEvent()),
        ),
        BlocProvider(
          create: (context) => LiteratureBloc(
            RepositoryProvider.of<MainRepository>(context).categoryRepository,
          )..add(const LiteratureLoadEvent()),
        ),
        BlocProvider(
          create: (context) => ComicBloc(
            RepositoryProvider.of<MainRepository>(context).categoryRepository,
          )..add(const ComicLoadEvent()),
        ),
        BlocProvider(
          create: (context) => ChildBloc(
            RepositoryProvider.of<MainRepository>(context).categoryRepository,
          )..add(const ChildLoadEvent()),
        ),
        BlocProvider(
          create: (context) => ScienceBloc(
            RepositoryProvider.of<MainRepository>(context).categoryRepository,
          )..add(const ScicenceLoadEvent()),
        ),
        BlocProvider(
          create: (context) => OtherBloc(
            RepositoryProvider.of<MainRepository>(context).categoryRepository,
          )..add(const OtherLoadEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          titleSpacing: 10,
          leadingWidth: 62,
          backgroundColor: AppColors.themeColor,
          foregroundColor: Colors.white,
          title: const MyCustomSearchBar(),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 1,
                //     blurRadius: 2,
                //     offset: const Offset(0, 1),
                //   ),
                // ],
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
                    tabAlignment: TabAlignment.start,
                    indicator: BoxDecoration(
                      color: themeColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    labelStyle: const TextStyle(fontSize: 13),
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
