import 'package:f_learner/module.old/interactive_viewer_builder/interactive_viewer_builder.dart';
import 'package:f_learner/module.old/interactive_viewer_builder/word_layout_page.dart';
import 'package:f_learner/module.old/layout/flex_layout_page.dart';
import 'package:f_learner/module.old/layout/flex_page.dart';
import 'package:f_learner/module.old/lens/lens_page.dart';
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
          PageModel3('StatefulView', const SfViewPageView()),
        ]),
        CategoryWidget(name: 'Word布局研究', pages: [
          PageModel3('Word布局尝试', const WordLayoutPage()),
          PageModel3(
              'InteractiveViewer.builder', const InteractiveViewerBuilder()),
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
