import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tokotok/bloc/cart_bloc.dart';
import 'package:tokotok/firebase/auth_services.dart';
import 'package:tokotok/firebase/cart_database.dart';
import 'package:tokotok/firebase/firestorage.dart';
import 'package:tokotok/models/product_cart.dart';
import 'package:tokotok/views/custom_theme.dart';

class CartPage extends StatelessWidget {
  void reloadCart(BuildContext context) async {
    User user = await AuthServices.getCurrentUser();
    context.read<CartBloc>().add(LoadCart(uid: user.uid));
  }

  @override
  Widget build(BuildContext context) {
    reloadCart(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Keranjang Anda",
          style: CustomTheme.Title,
        ),
        backgroundColor: CustomTheme.Background,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoaded) {
                  List<ProductCart> products = state.products;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ItemCart(
                          id: products[index].id,
                          idProduct: products[index].idProduct,
                          productName: products[index].productName,
                          favorite: false,
                          price: products[index].price,
                          quantity: products[index].quantity,
                          image: products[index].images,
                        );
                      });
                }
                if (state is CartError) {
                  return Center(
                    child: Text("Error"),
                  );
                }
                return Shimmer.fromColors(
                    child: ItemCart(
                      productName: "Nike Air Zoom Pegasus 36 Miami",
                      image: null,
                      price: 2000000,
                      favorite: false,
                    ),
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100]);
              },
            ),
          ),
          Container(
            height: 160,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey)],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Masukan code voucher",
                            hintStyle: TextStyle(
                                color: CustomTheme.Grey, fontSize: 12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3),
                                  bottomLeft: Radius.circular(3)),
                              borderSide: BorderSide(
                                color: CustomTheme.Light,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3),
                                  bottomLeft: Radius.circular(3)),
                              borderSide: BorderSide(
                                color: CustomTheme.Blue,
                              ),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8)),
                      ),
                      flex: 3,
                    ),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            "Check",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(CustomTheme.Blue),
                            side: MaterialStateProperty.all(BorderSide.none),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(3),
                                  bottomRight: Radius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total : ",
                      style: TextStyle(
                          color: CustomTheme.Dark, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rp. 4000000",
                      style: TextStyle(
                          color: CustomTheme.Blue, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Checkout"),
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width - 40, 40)),
                      backgroundColor:
                          MaterialStateProperty.all(CustomTheme.Blue)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ItemCart extends StatelessWidget {
  final String id;
  final String idProduct;
  final String productName;
  final String image;
  final int price;
  final int quantity;
  final bool favorite;
  ItemCart(
      {this.id,
      this.idProduct,
      this.productName,
      this.image,
      this.price,
      this.quantity = 1,
      this.favorite = false});

  Future<bool> dialogDelete(BuildContext context) async {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Yakin hapus dari keranjang?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    "Ya",
                    textAlign: TextAlign.end,
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "Tidak",
                    textAlign: TextAlign.end,
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      semanticContainer: false,
      child: Container(
        height: 80,
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            FutureBuilder(
                future: FireStorage.downloadURLExample(
                    image ?? "productImages/no_photo.png"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Image(
                      image: NetworkImage(snapshot.data),
                      height: 80,
                      width: 80,
                    );
                  }
                  return Shimmer(
                    gradient: LinearGradient(
                        colors: [Colors.grey, Colors.grey[100], Colors.grey]),
                    child: Image(
                      image: AssetImage("assets/image_46.png"),
                      height: 80,
                      width: 80,
                    ),
                  );
                }),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 7.5),
                        width: 150,
                        child: Text(
                          productName,
                          style: TextStyle(
                              color: CustomTheme.Dark,
                              fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Fitur belum tersedia")));
                          },
                          child: !favorite
                              ? Icon(
                                  Icons.favorite_border,
                                  color: CustomTheme.Grey,
                                )
                              : Icon(
                                  Icons.favorite,
                                  color: CustomTheme.Red,
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Material(
                        type: MaterialType.circle,
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            bool delete = await dialogDelete(context) ?? false;
                            if (delete) {
                              await CartDatabase.deleteCart(id)
                                  .then((value) => context
                                      .read<CartBloc>()
                                      .add(DeleteCart(id: id)))
                                  .onError((error, stackTrace) =>
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Gagal menghapus item"))));
                            }
                          },
                          child: Icon(
                            Icons.delete,
                            color: CustomTheme.Grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 7.5),
                        child: Text(
                          NumberFormat.currency(
                                  locale: "id",
                                  decimalDigits: 0,
                                  symbol: "Rp. ")
                              .format(price),
                          style: TextStyle(
                              color: CustomTheme.Blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () async {
                                if (quantity == 1) {
                                  bool delete =
                                      await dialogDelete(context) ?? false;
                                  if (delete) {
                                    await CartDatabase.deleteCart(id)
                                        .then((value) => context
                                            .read<CartBloc>()
                                            .add(DeleteCart(id: id)))
                                        .onError((error, stackTrace) =>
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Gagal menghapus item"))));
                                  }
                                } else {
                                  await CartDatabase.setQuantity(
                                          id, quantity - 1)
                                      .then((value) => context
                                          .read<CartBloc>()
                                          .add(SetQuantity(
                                              id: id, quantity: quantity - 1)))
                                      .onError((error, stackTrace) =>
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text("Gagal"))));
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 25,
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: CustomTheme.Grey),
                                ),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: CustomTheme.Light)),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 40,
                            alignment: Alignment.center,
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: CustomTheme.Light),
                                    top: BorderSide(color: CustomTheme.Light)),
                                color: CustomTheme.Light),
                            child: TextField(
                              controller: new TextEditingController(
                                  text: quantity.toString()),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              enabled: false,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              scrollPadding: EdgeInsets.zero,
                              decoration: InputDecoration(
                                  border: InputBorder.none, isDense: true),
                            ),
                          ),
                          Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () async {
                                await CartDatabase.setQuantity(id, quantity + 1)
                                    .then((value) => context
                                        .read<CartBloc>()
                                        .add(SetQuantity(
                                            id: id, quantity: quantity + 1)))
                                    .onError((error, stackTrace) =>
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text("Gagal"))));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 25,
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: CustomTheme.Grey),
                                ),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: CustomTheme.Light)),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
