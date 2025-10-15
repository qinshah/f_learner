import 'package:f_learner/data_model/page_model.dart';
import 'package:f_learner/module.demo/counter/provider_page_view.dart';
import 'package:f_learner/module.demo/state_management/vsvl/vsvl_page.dart';
import 'package:f_learner/module.old/bbs/bbs_page.dart';
import 'package:f_learner/module.old/nav_or_routes/bottom_nav_page.dart';
import 'package:f_learner/module.old/nav_or_routes/routes_nav_page.dart';
import 'package:f_learner/root/category_widget.dart';
import 'package:flutter/material.dart';

class DemosPageView extends StatelessWidget {
  const DemosPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        CategoryWidget(name: '计数器状态管理', pages: [
          PageModel3('provider', const ProviderPageView()),
        ]),
        CategoryWidget(name: '导航或路由', pages: [
          PageModel3('简单底部导航', const BottomNavPage()),
          PageModel3('嵌套路由导航', const RoutesNavPage()),
        ]),
        CategoryWidget(name: '我的状态管理尝试', pages: [
          PageModel3('vsvl状态管理', const VsvlPage()),
          PageModel3('通过状态构建', const BbsPage()),
        ]),
      ],
    );
  }
}
