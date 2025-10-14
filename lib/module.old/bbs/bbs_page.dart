import 'src/code.dart';

import 'package:flutter/material.dart';

class BbsPage extends BbsWidget<BbsPageState, BbsPageLogic> {
  const BbsPage({super.key});

  @override
  BbsPageLogic createBbsLogic() => BbsPageLogic(BbsPageState());

  @override
  Widget build(
      BbsPageState curState, BbsPageLogic logic, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通过状态构建'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('计数器：${curState.counter}'),
            ElevatedButton(
              onPressed: () => logic.incrementCount(curState),
              child: const Text('点击'),
            ),
          ],
        ),
      ),
    );
  }
}

class BbsPageState extends BbsState {
  int counter = 0;
}

class BbsPageLogic extends BbsLogic<BbsPageState> {
  BbsPageLogic(super.state);

  void incrementCount(BbsPageState curState) {
    rebuildWidget(curState..counter += 1);
  }
}
