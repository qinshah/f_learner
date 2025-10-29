import 'package:f_learner/data_model/page_model.dart';
import 'package:f_learner/module.old/flame/flame_page.dart';
import 'package:f_learner/module.old/lottie/lottie_page.dart';
import 'package:f_learner/module.old/open_file/open_file_page.dart';
// import 'package:f_learner/module.package/graph_editor/vyuh_node_flow_page.dart';
import 'package:f_learner/module.old/volume_ctrl/volume_ctrl_page.dart';
import 'package:f_learner/module.old/waterfall_layout/waterfall_layout_page.dart';
import 'package:f_learner/module.package/rich_text/appflowy/appflowy_page.dart';
import 'package:f_learner/module.package/share_plus/share_plus_page.dart';
import 'package:f_learner/root/category_widget.dart';
import 'package:flutter/material.dart';

class PackagesPageView extends StatelessWidget {
  const PackagesPageView({super.key});

  final targetPlatformOhosMissError = const Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 64, color: Colors.orange),
          SizedBox(height: 16),
          Text('此页面插件使用鸿蒙flutter会出错'),
          SizedBox(height: 16),
          BackButton(),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        CategoryWidget(name: '图形编辑器', pages: [
          // 版本兼容问题暂无法在3.32运行
          // PageModel3('vyuh_node_flow', const VyuhNodeFlowPage()),
        ]),
        CategoryWidget(name: '富文本编辑器', pages: [
          PageModel3('appflowy', const AppflowyPage()),
          // switch(defaultTargetPlatform)缺少TargetPlatform.ohos
          PageModel3('got_markdown', targetPlatformOhosMissError),
          PageModel3('Quill富文本', targetPlatformOhosMissError),
          PageModel3('Fleather富文本', targetPlatformOhosMissError),
        ]),
        CategoryWidget(name: '布局组件', pages: [
          PageModel3('瀑布流(图片)', const WaterfallLayoutPage()),
        ]),
        CategoryWidget(name: '游戏开发', pages: [
          PageModel3('Flame框架', const FlamePage()),
        ]),
        CategoryWidget(name: '动画组件', pages: [
          PageModel3('lottie动画', const LottiePage()),
        ]),
        CategoryWidget(name: '系统功能', pages: [
          PageModel3('内容分享', const SharePlusPage()),
          PageModel3('音量控制', const VolumeCtrlPage()),
          PageModel3('打开文件', const OpenFilePage()),
        ]),
      ],
    );
  }
}
