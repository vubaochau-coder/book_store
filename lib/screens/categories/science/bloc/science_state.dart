part of 'science_bloc.dart';

abstract class ScienceState extends Equatable {
  const ScienceState();

  @override
  List<Object> get props => [];
}

class ScienceLoadingState extends ScienceState {}

class ScienceLoadingSuccessfulState extends ScienceState {
  final List<ShortProductDataModel> listScience;
  final int sortType;

  const ScienceLoadingSuccessfulState({
    required this.listScience,
    required this.sortType,
  });
}
