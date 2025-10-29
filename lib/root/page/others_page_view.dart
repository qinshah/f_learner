import 'package:f_learner/module.old/infinite_canvas.dart/infinite_canvas.dart';
import 'package:f_learner/module.old/infinite_canvas.dart/infinite_canvas2.dart';
import 'package:f_learner/module.old/infinite_canvas.dart/infinite_canvas3.dart';
import 'package:f_learner/module.old/interactive_viewer_builder/scroll_view_page.dart';
import 'package:f_learner/module.old/interactive_viewer_builder/word_layout_page.dart';
import 'package:f_learner/module.old/layout/flex_layout_page.dart';
import 'package:f_learner/module.old/layout/flex_page.dart';
import 'package:f_learner/module.old/lens/lens_page.dart';
import 'package:f_learner/module.old/my_appflowy/appflowy_try.dart';
import 'package:f_learner/module.old/sf_view/sf_view_page_view.dart';
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
        CategoryWidget(name: '我的测试', pages: [
          PageModel3('Word布局尝试', const WordLayoutPage()),
          PageModel3('无限画布3', const InfiniteCanvas3()),
          PageModel3('无限画布2', const InfiniteCanvas2()),
          PageModel3('无限画布', const InfiniteCanvas()),
          PageModel3('滚动视图', const ScrollViewPage()),
          PageModel3('StatefulView', const SfViewPageView()),
          PageModel3('AppflowyTry', const AppflowyTry()),
        ]),
        CategoryWidget(name: '布局研究', pages: [
          PageModel3('Flex研究', const FlexLayoutPage()),
          PageModel3('Flex布局', const FlexPage()),
          PageModel3('透镜', const LensPage()),
        ]),
      ],
    );
  }
}
