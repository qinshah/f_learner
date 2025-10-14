import 'package:flutter/material.dart';

import '../../data_model/page_model.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  late final List<PageModel2> _pages = [
    PageModel2(
        '首页',
        PageBuilder(
          key: Key('首页'),
        ),
        const Icon(Icons.home)),
    PageModel2(
        '搜索',
        PageBuilder(
          key: Key('搜索'),
        ),
        const Icon(Icons.search)),
    PageModel2(
        '我的',
        PageBuilder(
          key: Key('我的'),
        ),
        const Icon(Icons.person)),
  ];
  int _currentIndex = 0;

  void _changePage(int tapedIndex) {
    setState(() {
      _currentIndex = tapedIndex;
    });
  }

  // build函数主要是负责UI的构建
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('底部导航')),
      // body: _pages[_currentIndex].page,
      // 用IndexedStack解决页面切换的状态丢失问题
      // IndexedStack是用页面叠加实现的
      // 问题是一旦加载，所有的child（children）全部会加载
      body: IndexedStack(
        index: _currentIndex,
        children: _pages.map((e) => e.page).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _pages
            .map((e) => BottomNavigationBarItem(
                  icon: e.icon,
                  label: e.name,
                ))
            .toList(),
        onTap: _changePage,
      ),
    );
  }
}

class PageBuilder extends StatefulWidget {
  const PageBuilder({required super.key});

  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  @override
  Widget build(BuildContext context) {
    print('key为${widget.key}的页面被构建了');
    return ListView.builder(
      itemBuilder: (context, index) {
        return Text(index.toString());
      },
    );
  }
}
