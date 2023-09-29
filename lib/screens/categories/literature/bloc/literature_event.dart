part of 'literature_bloc.dart';

abstract class LiteratureEvent extends Equatable {
  const LiteratureEvent();

  @override
  List<Object> get props => [];
}

class LiteratureLoadEvent extends LiteratureEvent {
  const LiteratureLoadEvent();
}

class UpdateSortTypeEvent extends LiteratureEvent {
  final BookSortType newType;

  const UpdateSortTypeEvent({required this.newType});
}
