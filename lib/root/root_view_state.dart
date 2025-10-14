import 'package:flutter/material.dart';

class RootViewState {
  int pageIndex = 0;
  final pageViewCntlr = PageController();
  final GlobalKey? pageKey = GlobalKey();
}
