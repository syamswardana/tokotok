import 'package:flutter/material.dart';
import 'package:tokotok/base%20views/card_product.dart';
import 'package:tokotok/base%20views/item_category.dart';
import 'package:tokotok/views/custom_theme.dart';
import 'package:dots_indicator/dots_indicator.dart';

class Homapage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageController offersController = new PageController();
    List<OfferPage> offers = [];
    int indexPage = 0;
    offers.add(OfferPage(
      title: "Super Flash Sale",
      subtitle: "30 Maret sampai 2 April",
      color: CustomTheme.Blue,
    ));
    offers.add(OfferPage(
      title: "Mega Electronic Sale",
      subtitle: "30 Maret sampai 2 April",
      color: CustomTheme.Purple,
    ));
    offers.add(OfferPage(
      title: "Mandiri Discount",
      subtitle: "30 Maret sampai 2 April",
      color: CustomTheme.Yellow,
    ));
    return Scaffold(
      backgroundColor: CustomTheme.Background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomTheme.Background,
        actions: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 5, 5),
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search)),
            ),
          )),
          IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: CustomTheme.Grey,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: CustomTheme.Grey,
              ),
              onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: PageView(
                onPageChanged: (index) {
                  indexPage = index;
                },
                controller: offersController,
                children: offers,
              ),
            ),
            DotsIndicator(
              dotsCount: offers.length,
              position: indexPage.toDouble(),
              decorator: DotsDecorator(
                  activeColor: CustomTheme.Blue, color: CustomTheme.Grey),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kategori",
                    style: CustomTheme.Title.copyWith(fontSize: 16),
                  ),
                  Text(
                    "Semua Kategori",
                    style: CustomTheme.Title.copyWith(
                        color: CustomTheme.Blue, fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  ItemCategory(
                    label: "Otomotif",
                    icon: Icon(
                      Icons.car_rental,
                      color: CustomTheme.Blue,
                    ),
                  ),
                  ItemCategory(
                    label: "Hobi",
                    icon: Icon(
                      Icons.agriculture_outlined,
                      color: CustomTheme.Blue,
                    ),
                  ),
                  ItemCategory(
                    label: "Komputer",
                    icon: Icon(
                      Icons.computer,
                      color: CustomTheme.Blue,
                    ),
                  ),
                  ItemCategory(
                    label: "Fotografi",
                    icon: Icon(
                      Icons.camera_alt,
                      color: CustomTheme.Blue,
                    ),
                  ),
                  ItemCategory(
                    label: "Makanan",
                    icon: Icon(
                      Icons.fastfood,
                      color: CustomTheme.Blue,
                    ),
                  ),
                  ItemCategory(
                    label: "Buku",
                    icon: Icon(
                      Icons.book,
                      color: CustomTheme.Blue,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Flash Sale",
                    style: CustomTheme.Title.copyWith(fontSize: 16),
                  ),
                  Text(
                    "Lihat Semua",
                    style: CustomTheme.Title.copyWith(
                        color: CustomTheme.Blue, fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CardProduct(
                    productName: "FS - Nike Air Max 270 React lalalalalala",
                    price: 4000000,
                    discount: 50,
                    img: AssetImage("assets/image_46.png"),
                  ),
                  CardProduct(
                    productName: "FS - QUILTED MAXI CROS...",
                    price: 3000000,
                    discount: 24,
                    img: AssetImage("assets/image_54.png"),
                  ),
                  CardProduct(
                    productName: "FS - Nike Air Max 270 React...",
                    price: 3000000,
                    discount: 50,
                    img: AssetImage("assets/image_49.png"),
                  ),
                  CardProduct(
                    productName: "FS - Nike Air Max 270 React lalalalalala",
                    price: 4000000,
                    discount: 24,
                    img: AssetImage("assets/image_46.png"),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mega Sale",
                    style: CustomTheme.Title.copyWith(fontSize: 16),
                  ),
                  Text(
                    "Lihat Semua",
                    style: CustomTheme.Title.copyWith(
                        color: CustomTheme.Blue, fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CardProduct(
                    productName: "FS - Nike Air Max 270 React lalalalalala",
                    price: 4000000,
                    discount: 50,
                    img: AssetImage("assets/image_46.png"),
                  ),
                  CardProduct(
                    productName: "FS - QUILTED MAXI CROS...",
                    price: 3000000,
                    discount: 24,
                    img: AssetImage("assets/image_54.png"),
                  ),
                  CardProduct(
                    productName: "FS - Nike Air Max 270 React...",
                    price: 3000000,
                    discount: 50,
                    img: AssetImage("assets/image_49.png"),
                  ),
                  CardProduct(
                    productName: "FS - Nike Air Max 270 React lalalalalala",
                    price: 4000000,
                    discount: 24,
                    img: AssetImage("assets/image_46.png"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OfferPage extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final String urlBackground;
  OfferPage({this.color, this.title, this.subtitle, this.urlBackground});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(subtitle, style: TextStyle(color: Colors.white, fontSize: 16))
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color != null ? color : null,
          image: (urlBackground == null)
              ? null
              : DecorationImage(image: NetworkImage(urlBackground))),
    );
  }
}
