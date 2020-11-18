import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends Container implements PreferredSizeWidget 
{
  CustomTabBar(this.color, this.tabBar);

  final Color color;
  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
    color: color,
    child: tabBar,
  );
}