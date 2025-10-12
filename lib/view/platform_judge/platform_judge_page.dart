import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformJudgePage extends StatefulWidget {
  const PlatformJudgePage({super.key});

  @override
  State<PlatformJudgePage> createState() => _PlatformJudgePageState();
}

class _PlatformJudgePageState extends State<PlatformJudgePage> {
  /// 这个方法调用的是[defaultTargetPlatform]
  /// 即使运行在浏览器中也能判断真正的操作系统
  String _getOSName() {
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => '安卓',
      TargetPlatform.iOS => 'IOS',
      TargetPlatform.macOS => '苹果Mac',
      TargetPlatform.windows => '微软Windows',
      TargetPlatform.linux => 'Linux',
      TargetPlatform.fuchsia => '谷歌Fuchsia',
      // 虽然默认判断上面的6个系统就够了
      // 但如果这个代码放在鸿蒙flutter中
      // 由于还存在ohos，就会导致报错
      // 有很多插件在鸿蒙flutter上因为这个问题报错

      // 所以这里忽略一下代码警告，继续判断
      // ignore: unreachable_switch_case
      _ => _getUnknownOSName(),
    };
  }

  String _getUnknownOSName() {
    if (kIsWeb) {
      // 如果是web
      // 调用Platform.operatingSystem和Platform.isAndroid等都会报错
      // 所以这里只能得出结论是运行在未知操作系统的浏览器中
      return '未知操作系统的浏览器';
      // 有趣的是如果在鸿蒙浏览器中运行这样的flutter页面
      // 是不是就是这个情况？答案有待验证
    } else {
      // 可以调用Platform.operatingSystem了
      return switch (Platform.operatingSystem) {
        // 这里增加鸿蒙系统的字符串名称
        // 如果是鸿蒙系统，这里就能判断出来了
        'ohos' => '鸿蒙',
        String() => '未知操作系统',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(Platform.operatingSystem);
    return Scaffold(
      appBar: AppBar(title: const Text('系统和平台判断')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('当前设备的操作系统：${_getOSName()}'),
            SizedBox(height: 20),
            Text('是否运行在Web平台(浏览器)：${kIsWeb ? '是' : '否'}'),
          ],
        ),
      ),
    );
  }
}
