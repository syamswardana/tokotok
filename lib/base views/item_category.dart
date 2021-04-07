import 'package:flutter/material.dart';
import 'package:tokotok/views/custom_theme.dart';

class ItemCategory extends StatelessWidget {
  final Widget icon;
  final String label;
  ItemCategory({this.icon, this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 45,
            child: IconButton(
                padding: EdgeInsets.all(0),
                icon: Container(
                  height: 55,
                  width: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: CustomTheme.Light)),
                  child: icon,
                ),
                onPressed: () {}),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: CustomTheme.Grey),
          )
        ],
      ),
    );
  }
}
