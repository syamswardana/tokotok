part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<ProductCart> products;
  CartLoaded({this.products});

  @override
  List<Object> get props => [products];
}

class CartError extends CartState {}
