part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoaded extends AddressState {
  final List<Address> address;
  AddressLoaded({this.address});
  @override
  List<Object> get props => [address];
}
