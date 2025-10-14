import 'package:f_learner/data_model/page_model.dart';
import 'package:f_learner/root/root_view_logic.dart';
import 'package:f_learner/root_pages/api_page_view.dart';
import 'package:f_learner/root_pages/others_page_view.dart';
import 'package:f_learner/root_pages/packages_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../root_pages/demos_page_view.dart';
import 'root_view_state.dart';

class RootView extends StatelessWidget {
  const RootView({super.key});

  final _pages = const [
    PageModel('未分类', Icons.apps, OthersPageView()),
    PageModel('示例', Icons.code_rounded, DemosPageView()),
    PageModel('第三方包', Icons.category_outlined, PackagesPageView()),
    PageModel('框架API', Icons.extension, ApiPageView()),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RootViewLogic>(
      create: (_) => RootViewLogic(),
      child: OrientationBuilder(builder: (context, orientation) {
        final vertical = orientation == Orientation.portrait;
        return vertical ? _buildVertical(context) : _buildHorizontal(context);
      }),
    );
  }

  Widget _buildVertical(BuildContext context) {
    final logic = context.watch<RootViewLogic>();
    final state = logic.viewState;
    return Scaffold(
      body: _buildPage(state, Axis.horizontal),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: state.pageIndex,
        onTap: logic.changePage,
        items: _pages.map((e) {
          return BottomNavigationBarItem(
            icon: Icon(e.iconData),
            label: e.name,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHorizontal(BuildContext context) {
    final logic = context.watch<RootViewLogic>();
    final state = logic.viewState;
    return Material(
      child: Row(
        children: [
          NavigationRail(
            selectedIndex: state.pageIndex,
            labelType: NavigationRailLabelType.all,
            onDestinationSelected: logic.changePage,
            destinations: _pages.map((item) {
              return NavigationRailDestination(
                icon: Icon(item.iconData),
                label: Text(item.name),
              );
            }).toList(),
          ),
          Expanded(child: _buildPage(state, Axis.vertical)),
        ],
      ),
    );
  }

  Widget _buildPage(RootViewState state, Axis direction) {
    return PageView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: direction,
      key: state.pageKey,
      controller: state.pageViewCntlr,
      itemCount: _pages.length,
      itemBuilder: (BuildContext context, int index) {
        return _pages.toList()[index].view;
      },
    );
  }
}
