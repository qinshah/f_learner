import 'package:f_learner/root/root_view_state.dart';
import 'package:flutter/animation.dart';

import '../function/state_management.dart';

class RootViewLogic extends LogicNotifier {
  RootViewState viewState = RootViewState();

  void changePage(int value) {
    viewState.pageIndex = value;
    notifyListeners();
    viewState.pageViewCntlr.animateToPage(
      value,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  
  @override
  void rememberDispose() {
  }
}
