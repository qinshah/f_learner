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

import '../../data_model/page_model.dart';
import '../category_widget.dart';

class OthersPageView extends StatelessWidget {
  const OthersPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        CategoryWidget(name: 'Word布局研究', pages: [
          PageModel3('Word布局尝试', const WordLayoutPage()),
          PageModel3(
              'InteractiveViewer.builder', const InteractiveViewerBuilder()),
        ]),
        CategoryWidget(name: '富文本编辑器', pages: [
          PageModel3('appflowy', const AppflowyPage()),
          PageModel3('got_markdown', const GptMdPage()),
          PageModel3('Quill富文本', const QuillPage()),
          PageModel3('Fleather富文本', const FleatherPage()),
        ]),
        CategoryWidget(name: '布局研究', pages: [
          PageModel3('Flex研究', const FlexLayoutPage()),
          PageModel3('Flex布局', const FlexPage()),
          PageModel3('透镜', const LensPage()),
        ]),
        CategoryWidget(name: '布局组件', pages: [
          PageModel3('瀑布流(图片)', const WaterfallLayoutPage()),
        ]),
        CategoryWidget(name: '导航或路由', pages: [
          PageModel3('简单底部导航', const BottomNavPage()),
          PageModel3('嵌套路由导航', const RoutesNavPage()),
        ]),
        CategoryWidget(name: 'Flame游戏引擎', pages: [
          PageModel3('入门', const FlamePage()),
        ]),
        CategoryWidget(name: '系统', pages: [
          PageModel3('环境变量', const EnvVariablesPage()),
          PageModel3('进程(模拟终端)', const ProcessPage()),
          PageModel3('系统和平台判断', const PlatformJudgePage()),
          PageModel3('音量控制', const VolumeCtrlPage()),
          PageModel3('打开文件', const OpenFilePage()),
        ]),
        CategoryWidget(name: '实用组件', pages: [
          PageModel3('lottie动画', const LottiePage()),
        ]),
      ],
    );
  }
}
