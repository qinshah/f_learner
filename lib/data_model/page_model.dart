import 'package:flutter/widgets.dart';

class PageModel2 {
  final String name;
  final Widget icon;
  final Widget page;
 const PageModel2(this.name, this.page, this.icon);
}

class PageModel {
  final String name;
  final IconData iconData;
  final Widget view;
 const PageModel(
    this.name,
    this.iconData,
    this.view,
  );
}
