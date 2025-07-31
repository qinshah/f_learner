import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import 'bottom_nav/bottom_nav_page.dart';
import 'flame/flame_page.dart';
import 'platform_judge/platform_judge_page.dart';
import 'platform_view/platform_view_page.dart';
import 'volume_cntl/volume_cntl_page.dart';
import 'open_file/open_file_page.dart';
import 'lottie/lottie_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FLearner')),
      body: ListView(
        children: [
          _navTile('底部导航', const BottomNavPage()),
          _navTile('Flame 游戏引擎', const FlamePage()),
          _navTile('平台判断', const PlatformJudgePage()),
          if (UniversalPlatform.isOhos)
            _navTile('平台视图（鸿蒙）', const PlatformViewPage()),
          _navTile('音量控制', const VolumeCntlPage()),
          _navTile('打开文件', const OpenFilePage()),
          _navTile('lottie动画', const LottiePage()),
        ],
      ),
    );
  }

  Widget _navTile(String title, Widget page) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
