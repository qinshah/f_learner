import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:volume_controller/volume_controller.dart';

import '../widget/plugin_info_table.dart';

class VolumeCtrlPage extends StatefulWidget {
  const VolumeCtrlPage({super.key});

  @override
  State<VolumeCtrlPage> createState() => _VolumeCtrlPageState();
}

class _VolumeCtrlPageState extends State<VolumeCtrlPage> {
  late dynamic _volumeController;
  late final StreamSubscription<double> _subscription;

  double _currentVolume = 0;
  double _volumeValue = 0;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    newMethod();
  }

  Future<void> newMethod() async {
    _volumeController = VolumeController.instance;

    // Listen to system volume change
    _subscription = _volumeController.addListener((volume) {
      setState(() => _volumeValue = volume);
    }, fetchInitialVolume: true);

    _volumeController
        .isMuted()
        .then((isMuted) => setState(() => _isMuted = isMuted));
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('音量控制')),
      body: ListView(children: [
        PluginInfoTable(
          name: 'volume_controller',
          url: 'https://pub-web.flutter-io.cn/packages/volume_controller',
          platforms: [
            UniversalPlatformType.Android,
            UniversalPlatformType.IOS,
            UniversalPlatformType.Linux,
            UniversalPlatformType.MacOS,
            UniversalPlatformType.Windows,
          ],
        ),
        Text('当前音量: $_volumeValue'),
        Row(
          children: [
            Text('调整音量:'),
            Flexible(
              child: Slider(
                min: 0,
                max: 1,
                onChanged: (double value) async =>
                    await _volumeController.setVolume(value),
                value: _volumeValue,
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            Text('当前音量: $_currentVolume'),
            TextButton(
              onPressed: () async {
                _currentVolume = await _volumeController.getVolume();
                setState(() {});
              },
              child: Text('刷新'),
            ),
          ]),
        ),
        if (Platform.isAndroid || Platform.isIOS)
          // 是否显示系统UI，仅支持Android和iOS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('显示系统音量UI:${_volumeController.showSystemUI}'),
              TextButton(
                onPressed: () => setState(
                  () => _volumeController.showSystemUI =
                      !_volumeController.showSystemUI,
                ),
                child: Text('显示/隐藏 UI'),
              )
            ],
          ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text('是否静音:$_isMuted'),
              TextButton(
                onPressed: () async {
                  await updateMuteStatus(true);
                },
                child: Text('静音'),
              ),
              TextButton(
                onPressed: () async {
                  await updateMuteStatus(false);
                },
                child: Text('取消静音'),
              ),
              TextButton(
                onPressed: () async {
                  _isMuted = await _volumeController.isMuted();
                  setState(() {});
                },
                child: Text('刷新'),
              ),
            ],
          ),
        ),
        // TextButton(
        //   onPressed: UniversalPlatform.isOhos
        //       ? () {
        //           showAdaptiveDialog(
        //             context: context,
        //             barrierDismissible: true, // 允许点击外部关闭对话框
        //             builder: (_) => Dialog(child: OhosVolumePanel()),
        //           );
        //         }
        //       : null,
        //   child: Text('鸿蒙系统音量面板'),
        // ),
      ]),
    );
  }

  Future<void> updateMuteStatus(bool isMute) async {
    await _volumeController.setMute(isMute);
    if (Platform.isIOS) {
      // On iOS, the system does not update the mute status immediately
      // You need to wait for the system to update the mute status
      await Future.delayed(Duration(milliseconds: 50));
    }
    _isMuted = await _volumeController.isMuted();

    setState(() {});
  }
}

class OhosVolumePanel extends StatelessWidget {
  const OhosVolumePanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // child: OhosView(
      //   viewType: 'OhosVolumePanel',
      // ),
    );
  }
}
