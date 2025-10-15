import 'package:f_learner/function/sf_view/sf_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SfViewPageView extends StatelessWidget {
  const SfViewPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = _Logic(S(0));
    return Scaffold(
      appBar: AppBar(title: const Text('View=f(state, logic)')),
      body: ChangeNotifierProvider.value(
        value: logic,
        child: Center(
          child: ElevatedButton(
            onPressed: logic.increment,
            child: SfView<S, _Logic>(
              (state, logic) => Text('count: ${state.count}'),
            ),
          ),
        ),
      ),
    );
  }
}

class _Logic extends SfViewLogic<S> {
  _Logic(super.state);
  void increment() {
    state.count++;
    notifyListeners();
  }
}

class S extends SfViewState {
  int count;
  S(this.count);
}
