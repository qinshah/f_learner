import 'package:flutter/material.dart';
import 'vsvl.dart';

class VsvlPage extends StatefulWidget {
  const VsvlPage({super.key});

  @override
  State<VsvlPage> createState() => _VsvlPageState();
}

class _VsvlPageState extends State<VsvlPage>
    with LogicMix<VsvlPage, ExampleLogic> {
  @override
  ExampleLogic createLogic() => ExampleLogic(ExampleState());

  @override
  Widget build(BuildContext context) {
    final state = logic.state;
    return Scaffold(
      appBar: AppBar(title: const Text('vsvl状态管理')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('计数器：${state.count}'),
            SizedBox(width: 100),
            ElevatedButton(
              onPressed: () => logic.increment(),
              child: const Text('+1'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void rememberDispose() {
    // implement rememberDispose
  }
}

class ExampleState extends ViewState {
  int count = 0;
}

class ExampleLogic extends ViewLogic<ExampleState> {
  ExampleLogic(super.flutterState);

  void increment() {
    rebuild(state..count += 1);
  }
}
