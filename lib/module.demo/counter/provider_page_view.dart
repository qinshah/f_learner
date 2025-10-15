import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderPageView extends StatelessWidget {
  const ProviderPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = _MyNotifier();
    return Scaffold(
      appBar: AppBar(title: const Text('计数器(Provider)')),
      body: ChangeNotifierProvider(
        create: (context) => notifier,
        child: Builder(
          builder: (context) {
            final notifier = context.watch<_MyNotifier>();
            return Center(
              child: ElevatedButton(
                onPressed: notifier.increment,
                child: Text('按下计数：${notifier.count}'),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MyNotifier extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    notifyListeners();
  }
}
