part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class LoadAddress extends AddressEvent {
  @override
  List<Object> get props => [];
}
