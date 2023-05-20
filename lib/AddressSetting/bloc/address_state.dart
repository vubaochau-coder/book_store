part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressLoadingState extends AddressState {}

class AddressLoadingSuccessfulState extends AddressState {
  final List<AddressModel> listAddress;

  const AddressLoadingSuccessfulState({required this.listAddress});
}

class AddressEmptyState extends AddressState {}
