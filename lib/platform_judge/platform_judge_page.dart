import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

class PlatformJudgePage extends StatelessWidget {
  const PlatformJudgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('平台判断')),
      body: Center(
          child: Text(
        "Web: ${UniversalPlatform.isWeb} \n "
        "MacOS: ${UniversalPlatform.isMacOS} \n"
        "Windows: ${UniversalPlatform.isWindows} \n"
        "OhOS: ${UniversalPlatform.isOhos} \n"
        "Linux: ${UniversalPlatform.isLinux} \n"
        "Android: ${UniversalPlatform.isAndroid} \n"
        "IOS: ${UniversalPlatform.isIOS} \n"
        "Fuschia: ${UniversalPlatform.isFuchsia} \n",
      )),
    );
  }
}
