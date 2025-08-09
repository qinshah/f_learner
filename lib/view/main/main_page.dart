import 'package:flutter/material.dart';

import '../../model/page_model.dart';
import 'case_page.dart';
import 'layout_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final List<PageModel> _pages = [
    PageModel('案例', CasePage(), const Icon(Icons.cases)),
    PageModel('布局', LayoutPage(), const Icon(Icons.layers)),
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
      appBar: AppBar(title: const Text('FLearner')),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages.map((e) => e.page).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _pages
            .map((e) => BottomNavigationBarItem(
                  icon: e.icon,
                  label: e.title,
                ))
            .toList(),
        onTap: _changePage,
      ),
    );
  }
}
