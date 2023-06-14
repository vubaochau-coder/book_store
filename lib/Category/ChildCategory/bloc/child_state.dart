part of 'child_bloc.dart';

abstract class ChildState extends Equatable {
  const ChildState();

  @override
  List<Object> get props => [];
}

class ChildLoadingState extends ChildState {}

class ChildLoadingSuccessfulState extends ChildState {
  final List<ShortProductDataModel> listChild;
  final int sortType;

  const ChildLoadingSuccessfulState({
    required this.listChild,
    required this.sortType,
  });
}
