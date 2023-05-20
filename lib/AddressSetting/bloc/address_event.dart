part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class AddressLoadingEvent extends AddressEvent {}

class AddNewAddressEvent extends AddressEvent {
  final AddressModel newAddress;

  const AddNewAddressEvent({required this.newAddress});
}

class RemoveAddressEvent extends AddressEvent {
  final String idAddress;

  const RemoveAddressEvent({required this.idAddress});
}

class AddressUpdateEvent extends AddressEvent {
  final List<AddressModel> listAddress;

  const AddressUpdateEvent({required this.listAddress});
}

class AddressUpdateEmptyEvent extends AddressEvent {}

class AddressSelectedEvent extends AddressEvent {
  final String id;

  const AddressSelectedEvent({required this.id});
}
