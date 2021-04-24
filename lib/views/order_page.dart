import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tokotok/firebase/firestorage.dart';
import 'package:tokotok/firebase/order_database.dart';
import 'package:tokotok/views/custom_theme.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: CustomTheme.Background,
        leading: BackButton(
          color: CustomTheme.Grey,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Order",
          style: TextStyle(color: CustomTheme.Dark),
        ),
      ),
      body: FutureBuilder(
        future: OrderDatabase.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error connection"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text("Tidak ada order"),
            );
          }
          QuerySnapshot data = snapshot.data;
          List<QueryDocumentSnapshot> docs = data.docs;
          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                double total = 0;
                Map<String, dynamic> address = docs[index]["address"];
                List<dynamic> products = docs[index]["products"];
                for (var i = 0; i < products.length; i++) {
                  total +=
                      (products[i]["price"] * (1 - products[i]["discount"])) *
                          products[i]["quantity"];
                }
                return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: CustomTheme.Light),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order ID : " + docs[index].id,
                          softWrap: true,
                          style: TextStyle(color: CustomTheme.Dark),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Tgl order : " +
                              DateFormat("d-MMMM-yyyy").format(
                                  (docs[index]["orderDate"] as Timestamp)
                                      .toDate()),
                          style: TextStyle(color: CustomTheme.Dark),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Status : " + docs[index]["status"],
                          style: TextStyle(color: CustomTheme.Dark),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Alamat : ",
                          style: TextStyle(color: CustomTheme.Dark),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Total : " +
                              NumberFormat.currency(
                                      locale: "id",
                                      decimalDigits: 0,
                                      symbol: "Rp. ")
                                  .format(total),
                          style: TextStyle(color: CustomTheme.Dark),
                        ),
                        SizedBox(
                          height: 2.5,
                        ),
                        RichText(
                          text: TextSpan(
                              text: address["name"] + "\n",
                              style: TextStyle(
                                  color: CustomTheme.Dark, height: 1.5),
                              children: [
                                TextSpan(
                                    text: address["address"] +
                                        ", " +
                                        address["provinsi"] +
                                        "\n"),
                                TextSpan(text: address["noTelp"])
                              ]),
                        ),
                        ExpansionTile(
                          title: Text("Products"),
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        FutureBuilder(
                                            future:
                                                FireStorage.downloadURLExample(
                                                    products[index]["images"]),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Container(
                                                  width: 75,
                                                  height: 75,
                                                );
                                              }
                                              if (snapshot.hasError) {
                                                return Container(
                                                  width: 75,
                                                  height: 75,
                                                  child: Icon(
                                                    Icons.error,
                                                    color: CustomTheme.Red,
                                                  ),
                                                );
                                              }
                                              return Image.network(
                                                snapshot.data,
                                                width: 75,
                                                height: 75,
                                              );
                                            }),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              products[index]["productName"],
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              NumberFormat.currency(
                                                          locale: "id",
                                                          symbol: "Rp. ",
                                                          decimalDigits: 0)
                                                      .format(products[index]
                                                              ["price"] *
                                                          (1 -
                                                              products[index][
                                                                  "discount"])) +
                                                  " x " +
                                                  products[index]["quantity"]
                                                      .toString(),
                                              softWrap: true,
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  );
                                })
                          ],
                        )
                      ],
                    ));
              });
        },
      ),
    );
  }
}
