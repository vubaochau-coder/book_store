part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchLoadingEvent extends SearchEvent {}

class SearchingEvent extends SearchEvent {
  final String query;
  final bool isNewQuery;
  final String idQuery;

  const SearchingEvent({
    required this.query,
    required this.isNewQuery,
    required this.idQuery,
  });
}

class SearchRemoveEvent extends SearchEvent {
  final String idRemove;

  const SearchRemoveEvent({required this.idRemove});
}
