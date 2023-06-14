import 'package:book_store/models/search_suggestion_model.dart';
import 'package:flutter/material.dart';

class SearchSuggestionItem extends StatelessWidget {
  final SearchSuggestionModel searchModel;
  final VoidCallback onRemove;
  const SearchSuggestionItem(
      {super.key, required this.searchModel, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20, right: 8),
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          Expanded(
            child: Text(
              searchModel.query,
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(
              Icons.close,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
