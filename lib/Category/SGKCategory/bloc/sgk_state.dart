part of 'sgk_bloc.dart';

abstract class SgkState extends Equatable {
  const SgkState();

  @override
  List<Object> get props => [];
}

class SgkLoadingState extends SgkState {}

class SgkLoadingSuccessfulState extends SgkState {
  final List<ShortProductDataModel> listSGK;
  final int sortType;

  const SgkLoadingSuccessfulState({
    required this.listSGK,
    required this.sortType,
  });
}
