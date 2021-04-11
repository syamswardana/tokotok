import 'package:flutter/material.dart';
import 'package:tokotok/views/custom_theme.dart';

class OfferItem extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final String urlBackground;
  OfferItem({this.color, this.title, this.subtitle, this.urlBackground});
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {},
        hoverColor: CustomTheme.Light,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(subtitle,
                  style: TextStyle(color: Colors.white, fontSize: 16))
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: color != null ? color : null,
              image: (urlBackground == null)
                  ? null
                  : DecorationImage(image: NetworkImage(urlBackground))),
        ),
      ),
    );
  }
}
