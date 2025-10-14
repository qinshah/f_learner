import 'package:f_learner/module.demo/state_management/vsvl/vsvl_page.dart';
import 'package:f_learner/module.old/bbs/bbs_page.dart';
import 'package:f_learner/module.old/env_variables/env_variables_page.dart';
import 'package:f_learner/module.old/flame/flame_page.dart';
import 'package:f_learner/module.old/interactive_viewer_builder/interactive_viewer_builder.dart';
import 'package:f_learner/module.old/interactive_viewer_builder/word_layout_page.dart';
import 'package:f_learner/module.old/layout/flex_layout_page.dart';
import 'package:f_learner/module.old/layout/flex_page.dart';
import 'package:f_learner/module.old/lens/lens_page.dart';
import 'package:f_learner/module.old/lottie/lottie_page.dart';
import 'package:f_learner/module.old/nav_or_routes/bottom_nav_page.dart';
import 'package:f_learner/module.old/nav_or_routes/routes_nav_page.dart';
import 'package:f_learner/module.old/open_file/open_file_page.dart';
import 'package:f_learner/module.old/platform_judge/platform_judge_page.dart';
import 'package:f_learner/module.old/process/process_page.dart';
import 'package:f_learner/module.old/rich_text/appflowy/appflowy_page.dart';
import 'package:f_learner/module.old/rich_text/fleather_page.dart';
import 'package:f_learner/module.old/rich_text/gpt_md_page.dart';
import 'package:f_learner/module.old/rich_text/quill_page.dart';
import 'package:f_learner/module.old/volume_ctrl/volume_ctrl_page.dart';
import 'package:f_learner/module.old/waterfall_layout/waterfall_layout_page.dart';
import 'package:flutter/material.dart';

class OthersPageView extends StatefulWidget {
  const OthersPageView({super.key});

  @override
  State<OthersPageView> createState() => _OthersPageViewState();

  final targetPlatformOhosMissError = const Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 64, color: Colors.orange),
          SizedBox(height: 16),
          Text('此页面插件使用鸿蒙flutter时会有以下错误'),
          SizedBox(height: 16),
          Text('switch(defaultTargetPlatform)缺少TargetPlatform.ohos'),
          SizedBox(height: 16),
          BackButton(),
        ],
      ),
    ),
  );
}

class _OthersPageViewState extends State<OthersPageView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        _category('状态管理研究', [
          _navTile('vsvl状态管理', const VsvlPage()),
          _navTile('通过状态构建', const BbsPage()),
        ]),
        _category('Word布局研究', [
          _navTile('Word布局尝试', const WordLayoutPage()),
          _navTile(
              'InteractiveViewer.builder', const InteractiveViewerBuilder()),
        ]),
        _category('富文本编辑器', [
          _navTile('appflowy', const AppflowyPage()),
          _navTile(
            'got_markdown',
            widget
                .targetPlatformOhosMissError, // 依赖的flutter_math缺少TargetPlatform.ohos判断
          ),
          _navTile('Quill富文本', widget.targetPlatformOhosMissError),
          _navTile('Fleather富文本', widget.targetPlatformOhosMissError),
        ]),
        _category('布局研究', [
          _navTile('Flex研究', const FlexLayoutPage()),
          _navTile('Flex布局', const FlexPage()),
          _navTile('透镜', const LensPage()),
        ]),
        _category('布局组件', [
          _navTile('瀑布流(图片)', const WaterfallLayoutPage()),
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
          _navTile('系统和平台判断', const PlatformJudgePage()),
          _navTile('音量控制', const VolumeCtrlPage()),
          _navTile('打开文件', const OpenFilePage()),
        ]),
        _category('实用组件', [
          _navTile('lottie动画', const LottiePage()),
        ]),
      ],
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
