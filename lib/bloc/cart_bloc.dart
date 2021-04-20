import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:tokotok/firebase/cart_database.dart';
import 'package:tokotok/firebase/products_database.dart';
import 'package:tokotok/models/product_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is LoadCart) {
      if (state is CartLoaded) {
        yield CartInitial();
      }
      try {
        List<ProductCart> products = [];
        List<QueryDocumentSnapshot> docs =
            await CartDatabase.getCart(event.uid);
        for (var i = 0; i < docs.length; i++) {
          DocumentSnapshot snapshot =
              await ProductsDatabase.getProduct(docs[i]["idProduct"]);
          products.add(ProductCart(
              id: docs[i].id,
              idProduct: docs[i]["idProduct"],
              productName: snapshot["productName"],
              price: snapshot["price"],
              discount: snapshot["discount"],
              quantity: docs[i]["quantity"],
              images: snapshot["images"][0]));
        }
        yield CartLoaded(products: products);
      } catch (e) {
        yield CartError();
      }
    } else if (event is DeleteCart) {
      if (state is CartLoaded) {
        List<ProductCart> products = [];
        List<ProductCart> temp = (state as CartLoaded).products;

        for (var i = 0; i < temp.length; i++) {
          if (temp[i].id != event.id) {
            products.add(temp[i]);
          }
        }
        yield CartLoaded(products: products);
      }
    } else if (event is SetQuantity) {
      if (state is CartLoaded) {
        List<ProductCart> products = [];
        List<ProductCart> temp = (state as CartLoaded).products;
        for (var i = 0; i < temp.length; i++) {
          if (temp[i].id == event.id) {
            products.add(ProductCart(
                id: temp[i].id,
                idProduct: temp[i].idProduct,
                productName: temp[i].productName,
                price: temp[i].price,
                discount: temp[i].discount,
                quantity: event.quantity,
                images: temp[i].images));
          } else {
            products.add(temp[i]);
          }
        }
        yield CartLoaded(products: products);
      }
    }
  }
}
