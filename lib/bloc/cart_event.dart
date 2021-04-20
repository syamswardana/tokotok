part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {
  final String uid;
  LoadCart({this.uid});

  @override
  List<Object> get props => [uid];
}

class DeleteCart extends CartEvent {
  final String id;

  DeleteCart({this.id});

  @override
  List<Object> get props => [id];
}

class SetQuantity extends CartEvent {
  final String id;
  final int quantity;
  SetQuantity({this.id, this.quantity});

  @override
  List<Object> get props => [id, quantity];
}
