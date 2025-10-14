import 'package:flutter/material.dart';

class RoutesNavPage extends StatefulWidget {
  const RoutesNavPage({super.key});

  @override
  State<RoutesNavPage> createState() => _RoutesNavPageState();
}

class _RoutesNavPageState extends State<RoutesNavPage> {
  final List<RouteModel> _routes = [
    RouteModel(
      path: '/home',
      title: '首页',
      page: PageBuilder(
        key: Key('首页'),
      ),
      icon: const Icon(Icons.home),
    ),
    RouteModel(
      path: '/category',
      title: '分类',
      page: PageBuilder(
        key: Key('分类'),
      ),
      icon: const Icon(Icons.category),
    ),
    RouteModel(
      path: '/mine',
      title: '我的',
      page: PageBuilder(
        key: Key('我的'),
      ),
      icon: const Icon(Icons.person),
    ),
  ];

  final _indexNotifier = ValueNotifier(0);

  int get _index => _indexNotifier.value;
  final _navigatorKey = GlobalKey<NavigatorState>();

  void _changeRoute(int tapedIndex) {
    if (_index == tapedIndex) return;
    _indexNotifier.value = tapedIndex;
    final navigatorState = _navigatorKey.currentState!;
    // TODO 让浏览器能显示路由的路径
    navigatorState.pushReplacementNamed(
      _routes[tapedIndex].path,
    );
  }

  // build函数主要是负责UI的构建
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('嵌套路由导航')),
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return _routes[_index].page;
            },
            // settings: settings,
          );
        },
      ),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: _indexNotifier,
          builder: (context, index, child) {
            return BottomNavigationBar(
              currentIndex: index,
              items: _routes
                  .map((e) => BottomNavigationBarItem(
                        icon: e.icon,
                        label: e.title,
                      ))
                  .toList(),
              onTap: _changeRoute,
            );
          }),
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
    return Scaffold(
      appBar: AppBar(title: Text('key为${widget.key}的页面')),
      body: Center(child: Text('key为${widget.key}的页面')),
    );
  }
}

class RouteModel {
  final String path;
  final String title;
  final Widget page;
  final Widget icon;

  RouteModel({
    required this.path,
    required this.title,
    required this.page,
    required this.icon,
  });
}
