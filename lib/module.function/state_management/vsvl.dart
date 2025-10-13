import 'package:flutter/widgets.dart';

abstract class ViewState {}

abstract class ViewLogic<T extends ViewState> {
  final void Function(VoidCallback fn) setState;
  T state;
  ViewLogic(this.setState, this.state);

  void rebuild(T newState) {
    setState(() => state = newState);
  }
}
