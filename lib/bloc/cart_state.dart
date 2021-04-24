part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<ProductCart> products;
  final int total;
  CartLoaded({this.products, this.total});

  @override
  List<Object> get props => [products, total];
}

class CartError extends CartState {}
