import 'package:book_store/custom_widgets/custom_page_route.dart';
import 'package:book_store/core/models/search_suggestion_model.dart';
import 'package:book_store/screens/search/bloc/search_bloc.dart';
import 'package:book_store/screens/search/ui/search_loading_page.dart';
import 'package:book_store/screens/search/ui/search_result_page.dart';
import 'package:book_store/screens/search/ui/search_suggestion_item.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      bloc: BlocProvider.of<SearchBloc>(context)..add(SearchLoadingEvent()),
      listener: (context, state) {
        if (state is SearchCompletedState) {
          FocusManager.instance.primaryFocus?.unfocus();
          Navigator.of(context).push(
            PageRouteSlideTransition(
              child: SearchResultPage(
                listProducts: state.searchResult,
                query: state.query,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const SearchLoadingPage();
        }
        if (state is SearchCompletedState) {
          return const SizedBox();
        }
        return buildSearchPage(context, state.searchedList);
      },
    );
  }

  Widget buildSearchPage(
      BuildContext context, List<SearchSuggestionModel> searcheds) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 62,
        titleSpacing: 10,
        title: SizedBox(
          height: 36,
          child: TextField(
            autofocus: true,
            controller: searchController,
            style: const TextStyle(fontSize: 13),
            textInputAction: TextInputAction.search,
            onEditingComplete: () {
              if (searchController.text.trim().isNotEmpty) {
                search(context, searchController.text.trim(), searcheds);
              }
            },
            decoration: InputDecoration(
              hintText: 'Tìm kiếm sản phẩm',
              hintStyle: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: EdgeInsets.zero,
              prefixIcon: Icon(
                Icons.search,
                color: themeColor,
              ),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              search(context, searcheds[index].query, searcheds);
            },
            child: SearchSuggestionItem(
              searchModel: searcheds[index],
              onRemove: () {
                BlocProvider.of<SearchBloc>(context)
                    .add(SearchRemoveEvent(idRemove: searcheds[index].id));
              },
            ),
          );
        },
        itemCount: searcheds.length,
      ),
    );
  }

  void search(
      BuildContext context, String query, List<SearchSuggestionModel> suggest) {
    if (query.isNotEmpty) {
      bool isSearched = false;
      String idQuery = '';

      for (var item in suggest) {
        if (query == item.query) {
          isSearched = true;
          idQuery = item.id;
        }
      }

      BlocProvider.of<SearchBloc>(context).add(SearchingEvent(
        query: query,
        isNewQuery: !isSearched,
        idQuery: idQuery,
      ));
    }
  }
}
