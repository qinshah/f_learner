import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveCE extends StatefulWidget {
  const HiveCE({super.key});

  @override
  State<HiveCE> createState() => _HiveCEState();
}

class _HiveCEState extends State<HiveCE> {
  final _counterBoxName = 'HiveCE';

  bool _loding = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Hive.initFlutter();
    final box = await Hive.openBox(_counterBoxName);
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
    final box = Hive.box(_counterBoxName);
    return Scaffold(
      appBar: AppBar(title: const Text('Hive CE Example')),
      body: Builder(builder: (context) {
        if (_loding) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('重启后数据还存在', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            const Text('按下按钮的总次数'),
            SizedBox(height: 2),
            ElevatedButton(
              onPressed: () {
                box.putAt(0, box.getAt(0) + 1);
                setState(() {
                  // box[0] changed
                });
              },
              child: Text('${box.getAt(0)}'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('将'),
                SizedBox(
                  width: 50,
                  child: TextField(
                    onChanged: (value) => _putValue = value,
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                  onPressed: () => box.put(_putKey, _putValue),
                  child: Text('存储'),
                ),
                Text('到盒子'),
                SizedBox(
                  width: 50,
                  child: TextField(
                    onChanged: (value) => _putKey = value,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() => _gotValue = box.get(_getKey));
                  },
                  child: Text('获取'),
                ),
                Text('盒子'),
                SizedBox(
                  width: 60,
                  child: TextField(
                    onChanged: (value) => _getKey = value,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text('的数据：'),
              ],
            ),
            SizedBox(height: 10),
            Text(_gotValue),
          ],
        );
      }),
    );
  }

  String _putValue = '';
  String _putKey = '';
  String _getKey = '';
  String _gotValue = '';
}
