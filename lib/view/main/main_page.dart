import 'package:flutter/material.dart';

import '../flame/flame_page.dart';
import '../nav_or_routes/bottom_nav_page.dart';
import '../nav_or_routes/routes_nav_page.dart';
import '../platform_judge/platform_judge_page.dart';
import '../env_variables/env_variables_page.dart';
import '../process/process_page.dart';
// import '../quill/quill_page.dart'; // 不支持鸿蒙flutter
import '../open_file/open_file_page.dart';
import '../lottie/lottie_page.dart';
import '../lens/lens_page.dart';
import '../flex_layout/flex_layout_page.dart';
import '../quill/quill_page.dart';
import '../volume_ctrl/volume_ctrl_page.dart';
import '../waterfall_layout/waterfall_layout_page.dart';
import '../bbs/bbs_page.dart';

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
        padding: const EdgeInsets.all(8),
        children: [
          _category('富文本', [
            _navTile('Quill富文本', const QuillPage()),
          ]),
          _category('状态管理研究', [
            _navTile('通过状态构建', const BbsPage()),
          ]),
          _category('组件/布局研究', [
            _navTile('瀑布流(图片)', const WaterfallLayoutPage()),
            _navTile('透镜', const LensPage()),
            _navTile('Flex研究', const FlexLayoutPage()),
          ]),
          _category('导航或路由', [
            _navTile('简单底部导航', const BottomNavPage()),
            _navTile('嵌套路由导航', const RoutesNavPage()),
          ]),
          _category('Flame游戏引擎', [
            _navTile('入门', const FlamePage()),
          ]),
          _category('系统', [
            _navTile('环境变量', const EnvVariablesPage()),
            _navTile('进程(模拟终端)', const ProcessPage()),
            _navTile('平台判断', const PlatformJudgePage()),
            // if (UniversalPlatform.isOhos)
            //   _navTile('平台视图（鸿蒙）', const PlatformViewPage()),
            _navTile('音量控制', const VolumeCtrlPage()),
            _navTile('打开文件', const OpenFilePage()),
          ]),
          _category('实用组件', [
            // _navTile('Quill富文本', const QuillPage()), //不支持鸿蒙flutter
            _navTile('lottie动画', const LottiePage()),
          ]),
        ],
      ),
    );
  }

  Widget _category(String name, List<Widget> children) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: ExpansionTile(
        shape: OutlineInputBorder(),
        initiallyExpanded: true,
        title: Text(name),
        textColor: primaryColor,
        collapsedTextColor: primaryColor,
        childrenPadding: EdgeInsets.only(left: 6),
        children: children,
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
