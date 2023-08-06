part of 'other_bloc.dart';

abstract class OtherState extends Equatable {
  const OtherState();

  @override
  List<Object> get props => [];
}

class OtherLoadingState extends OtherState {}

class OtherLoadingSuccessfulState extends OtherState {
  final List<ShortProductDataModel> listOther;
  final int sortType;

  const OtherLoadingSuccessfulState({
    required this.listOther,
    required this.sortType,
  });
}
