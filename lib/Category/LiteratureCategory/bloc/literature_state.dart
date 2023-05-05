part of 'literature_bloc.dart';

abstract class LiteratureState extends Equatable {
  const LiteratureState();

  @override
  List<Object> get props => [];
}

class LiteratureLoadingState extends LiteratureState {}

class LiteratureLoadingSuccessfulState extends LiteratureState {
  final List<ProductDataModel> listLiterature;
  final int sortType;

  const LiteratureLoadingSuccessfulState({
    required this.listLiterature,
    required this.sortType,
  });

  // @override
  // List<Object> get props => [listLiterature, sortType];
}
