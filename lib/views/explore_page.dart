import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tokotok/base%20views/item_category.dart';
import 'package:tokotok/views/custom_theme.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              margin: EdgeInsets.fromLTRB(20, 20, 20, 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Fashion Pria",
                style: CustomTheme.Title.copyWith(fontSize: 14),
              ),
            ),
            Container(
              height: 180,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 15,
                    childAspectRatio: 1,
                    crossAxisCount: 4),
                children: [
                  ItemCategory(
                    label: "Atasan Pria",
                    icon: SvgPicture.asset(
                      "assets/icons/man_shirt.svg",
                    ),
                  ),
                  ItemCategory(
                    label: "Peralatan Kerja",
                    icon: SvgPicture.asset(
                      "assets/icons/man_bag.svg",
                    ),
                  ),
                  ItemCategory(
                    label: "Sepatu Pria",
                    icon: SvgPicture.asset(
                      "assets/icons/man_shoes.svg",
                    ),
                  ),
                  ItemCategory(
                    label: "Kaos Pria",
                    icon: SvgPicture.asset(
                      "assets/icons/man_tshirt.svg",
                    ),
                  ),
                  ItemCategory(
                    label: "Celana Pria",
                    icon: SvgPicture.asset(
                      "assets/icons/man_pants.svg",
                    ),
                  ),
                  ItemCategory(
                    label: "Dalaman Pria",
                    icon: SvgPicture.asset(
                      "assets/icons/man_underwear.svg",
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Fashion Wanita",
                style: CustomTheme.Title.copyWith(fontSize: 14),
              ),
            ),
            Container(
              height: 180,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 15,
                    childAspectRatio: 1,
                    crossAxisCount: 4),
                children: [
                  ItemCategory(
                    label: "Gaun",
                    icon: SvgPicture.asset(
                      "assets/icons/woman_dress.svg",
                    ),
                  ),
                  ItemCategory(
                    label: "Kaos Wanita",
                    icon: SvgPicture.asset(
                      "assets/icons/woman_tshirt.svg",
                    ),
                  ),
                  ItemCategory(
                    label: "Celana Wanita",
                    icon: SvgPicture.asset(
                      "assets/icons/woman_pants.svg",
                    ),
                  ),
                  ItemCategory(
                    label: "Rok Wanita",
                    icon: SvgPicture.asset(
                      "assets/icons/woman_skirt.svg",
                    ),
                  ),
                  ItemCategory(
                    label: "Tas Wanita",
                    icon: SvgPicture.asset(
                      "assets/icons/woman_bag.svg",
                    ),
                  ),
                  ItemCategory(
                    label: "Sepatu Wanita",
                    icon: SvgPicture.asset(
                      "assets/icons/woman_shoes.svg",
                    ),
                  ),
                  ItemCategory(
                    label: "Bikini Wanita",
                    icon: SvgPicture.asset(
                      "assets/icons/woman_bikini.svg",
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
