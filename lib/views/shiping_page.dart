import 'package:flutter/material.dart';
import 'package:tokotok/views/custom_theme.dart';

class ShippingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _selectedAddress = 0;
    return Scaffold(
      backgroundColor: CustomTheme.Background,
      appBar: AppBar(
        backgroundColor: CustomTheme.Background,
        elevation: 1,
        leading: BackButton(
          color: CustomTheme.Grey,
          onPressed: () {},
        ),
        title: Text(
          "Kirim ke",
          style: TextStyle(color: CustomTheme.Dark),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: CustomTheme.Blue,
              ),
              onPressed: () {})
        ],
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            bool selected = false;
            return Container(
              height: 200,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: (selected ? CustomTheme.Blue : CustomTheme.Light)),
                  borderRadius: BorderRadius.circular(3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rumah",
                    style: TextStyle(
                        color: CustomTheme.Dark, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Jalan Jawa 7 Blok L-23, \nSumbersari, Jember, Jawa Timur",
                    style: TextStyle(color: CustomTheme.Grey),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "088765345243",
                    style: TextStyle(color: CustomTheme.Grey),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Edit"),
                        style:
                            ElevatedButton.styleFrom(primary: CustomTheme.Blue),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: CustomTheme.Grey,
                          ),
                          onPressed: () {})
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
