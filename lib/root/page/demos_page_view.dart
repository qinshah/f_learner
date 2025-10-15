import 'package:f_learner/data_model/page_model.dart';
import 'package:f_learner/module.demo/state_management/vsvl/vsvl_page.dart';
import 'package:f_learner/module.old/bbs/bbs_page.dart';
import 'package:f_learner/root/category_widget.dart';
import 'package:flutter/material.dart';

class DemosPageView extends StatelessWidget {
  const DemosPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        CategoryWidget(name: '状态管理研究', pages: [
          PageModel3('vsvl状态管理', const VsvlPage()),
          PageModel3('通过状态构建', const BbsPage()),
        ]),
      ],
    );
  }

}