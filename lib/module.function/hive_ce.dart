import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveCE extends StatefulWidget {
  const HiveCE({super.key});

  @override
  State<HiveCE> createState() => _HiveCEState();
}

class _HiveCEState extends State<HiveCE> {
  final counterBox = 'counter';

  bool _loding = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Hive.initFlutter();
    final box = await Hive.openBox(counterBox);
    if (box.isEmpty) {
      await box.add(0);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _loding = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loding) {
      return const Center(child: CircularProgressIndicator());
    }
    final textTheme = TextTheme.of(context);
    final box = Hive.box(counterBox);
    return Scaffold(
      appBar: AppBar(title: const Text('Hive CE Example')),
      body: Builder(builder: (context) {
        if (_loding) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('You have pushed the button this many times:'),
              ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, box, widget) {
                  return Text(
                    box.getAt(0).toString(),
                    style: textTheme.headlineMedium,
                  );
                },
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => box.putAt(0, box.getAt(0) + 1),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
