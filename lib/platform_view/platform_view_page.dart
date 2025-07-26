import 'package:flutter/material.dart';

class PlatformViewPage extends StatefulWidget {
  const PlatformViewPage({super.key});

  @override
  State<PlatformViewPage> createState() => _PlatformViewPageState();
}

class _PlatformViewPageState extends State<PlatformViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('平台视图（鸿蒙）')),
      body: Center(
        child: OhosView(
          viewType: 'com.huangyuanlove/customView',
          onPlatformViewCreated: (id) {
            print('平台视图（鸿蒙）创建了，id: $id');
          },
        ),
      ),
    );
  }
}
