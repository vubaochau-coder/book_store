part of 'address_bloc.dart';

class AddressState extends Equatable {
  final List<AddressModel> listAddress;
  final bool isLoading;

  const AddressState({
    this.listAddress = const [],
    this.isLoading = false,
  });

  @override
  List<Object> get props => [listAddress, isLoading];

  AddressState copyWith({bool? isLoading, List<AddressModel>? listAddress}) {
    return AddressState(
      isLoading: isLoading ?? this.isLoading,
      listAddress: listAddress ?? this.listAddress,
    );
  }
}
