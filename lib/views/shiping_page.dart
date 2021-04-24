import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokotok/bloc/address_bloc.dart';
import 'package:tokotok/bloc/cart_bloc.dart';
import 'package:tokotok/firebase/address_database.dart';
import 'package:tokotok/firebase/auth_services.dart';
import 'package:tokotok/firebase/cart_database.dart';
import 'package:tokotok/firebase/order_database.dart';
import 'package:tokotok/models/address.dart';
import 'package:tokotok/models/product_cart.dart';
import 'package:tokotok/views/address_form.dart';
import 'package:tokotok/views/custom_theme.dart';
import 'package:tokotok/views/success_page.dart';

// ignore: must_be_immutable
class ShippingPage extends StatelessWidget {
  final bool isManage;
  ValueNotifier<int> _selectedAddress = ValueNotifier(0);

  ShippingPage({this.isManage});

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
    context.read<AddressBloc>().add(LoadAddress());
    return Scaffold(
        backgroundColor: CustomTheme.Background,
        appBar: AppBar(
          backgroundColor: CustomTheme.Background,
          elevation: 1,
          leading: BackButton(
            color: CustomTheme.Grey,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            isManage != null ? "Alamat" : "Kirim ke",
            style: TextStyle(color: CustomTheme.Dark),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: CustomTheme.Blue,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AddressForm();
                  }));
                })
          ],
        ),
        floatingActionButton: Visibility(
          visible: isManage != null ? false : true,
          child: ElevatedButton(
            onPressed: () async {
              User user = await AuthServices.getCurrentUser();
              DateTime now = DateTime.now();
              List<Map<String, dynamic>> products = [];
              Address address =
                  (context.read<AddressBloc>().state as AddressLoaded)
                      .address[_selectedAddress.value];
              List<ProductCart> list =
                  (context.read<CartBloc>().state as CartLoaded).products;
              for (var i = 0; i < list.length; i++) {
                products.add(list[i].toMap());
              }
              OrderDatabase.addOrder({
                "uid": user.uid,
                "orderDate": now,
                "products": products,
                "address": address.toMap(),
                "status": "diproses"
              }).then((value) async {
                await CartDatabase.batchDelete(user.uid);
                context.read<CartBloc>().add(LoadCart());
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return SuccessPage();
                }), (route) => route.isFirst);
              }).onError((error, stackTrace) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Gagal hapus")));
              });
            },
            child: Text("Order"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(CustomTheme.Blue),
                minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width - 40, 40))),
          ),
        ),
        body: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            if (state is AddressInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ValueListenableBuilder(
              valueListenable: _selectedAddress,
              builder: (context, selected, _) {
                return ListView.builder(
                  itemCount: (state as AddressLoaded).address.length,
                  itemBuilder: (context, index) {
                    return Material(
                      type: MaterialType.canvas,
                      child: InkWell(
                        onTap: () {
                          _selectedAddress.value = index;
                        },
                        child: Container(
                          height: 230,
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: (index == selected
                                      ? CustomTheme.Blue
                                      : CustomTheme.Light)),
                              borderRadius: BorderRadius.circular(3)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (state as AddressLoaded).address[index].name,
                                style: TextStyle(
                                    color: CustomTheme.Dark,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                (state as AddressLoaded)
                                        .address[index]
                                        .address +
                                    "\n" +
                                    (state as AddressLoaded)
                                        .address[index]
                                        .provinsi,
                                style: TextStyle(color: CustomTheme.Grey),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                (state as AddressLoaded).address[index].noTelp,
                                style: TextStyle(color: CustomTheme.Grey),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return AddressForm(
                                          address: (state as AddressLoaded)
                                              .address[index],
                                        );
                                      }));
                                    },
                                    child: Text("Edit"),
                                    style: ElevatedButton.styleFrom(
                                        primary: CustomTheme.Blue),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: CustomTheme.Grey,
                                      ),
                                      onPressed: () async {
                                        String id = (state as AddressLoaded)
                                            .address[index]
                                            .id;
                                        bool delete =
                                            await dialogDelete(context) ??
                                                false;
                                        if (delete) {
                                          AddressDatabase.deleteAddress(id)
                                              .then((value) {
                                            context
                                                .read<AddressBloc>()
                                                .add(LoadAddress());
                                          }).onError((error, stackTrace) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Gagal menghapus")));
                                          });
                                        }
                                      })
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ));
  }
}
