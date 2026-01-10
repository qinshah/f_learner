import 'package:f_learner/function/native/harmony_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:os_type/os_type.dart';

class AppOrientationPage extends StatefulWidget {
  const AppOrientationPage({super.key});

  @override
  State<AppOrientationPage> createState() => _AppOrientationPageState();
}

class _AppOrientationPageState extends State<AppOrientationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('应用方向'),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              bool isLandscape =
                  MediaQuery.of(context).orientation == Orientation.landscape;
              if (OS.isHarmony) {
                HarmonyChannel.setMiniWindowLandscape(!isLandscape);
              }
              if (isLandscape) {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown
                ]);
              } else {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight
                ]);
              }
            },
            child: Text('切换')),
      ),
    );
  }
}
