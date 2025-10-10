import 'package:flutter/material.dart';

abstract class BbsWidget<StateT extends BbsState, LogicT extends BbsLogic>
    extends StatefulWidget {
  const BbsWidget({super.key});

  @override
  State<BbsWidget> createState() => _BbsWidgetState();

  LogicT createBbsLogic();

  Widget build(StateT curState, LogicT logic, BuildContext context);
}

class _BbsWidgetState<LogicT extends BbsLogic> extends State<BbsWidget> {
  late final _logic = widget.createBbsLogic();

  @override
  void initState() {
    super.initState();
    _logic.rebuildWidget = (BbsState newState) {
      setState(() {
        _logic._state = newState;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(_logic._state, _logic, context);
  }
}

abstract class BbsLogic<StateT extends BbsState> {
  BbsLogic(this._state);
  StateT _state;

  ValueChanged<StateT> rebuildWidget = (newState) {};
}

abstract class BbsState {}
