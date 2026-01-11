import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MobileStatusBarPage extends StatefulWidget {
  const MobileStatusBarPage({super.key});

  @override
  State<MobileStatusBarPage> createState() => _MobileStatusBarPageState();
}

class _MobileStatusBarPageState extends State<MobileStatusBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('手机状态栏')),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Text('SystemUiMode'),
          for (var type in SystemUiMode.values)
            ElevatedButton(
              onPressed: () {
                SystemChrome.setEnabledSystemUIMode(type);
              },
              child: Text('$type'),
            ),
        ],
      ),
    );
  }
}
