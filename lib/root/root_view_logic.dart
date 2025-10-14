import 'package:f_learner/root/root_view_state.dart';
import 'package:flutter/material.dart';

class RootViewLogic extends ChangeNotifier {
  RootViewState viewState = RootViewState();

  int pageIndex = 0;

  void changePage(int value) {
    pageIndex = value;
    notifyListeners();
    viewState.pageViewCntlr.animateToPage(
      value,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
