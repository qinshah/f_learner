import 'dart:math';

import 'package:flutter/material.dart';

class FlexLayoutPage extends StatefulWidget {
  const FlexLayoutPage({super.key});

  @override
  State<FlexLayoutPage> createState() => _FlexLayoutPageState();
}

class _FlexLayoutPageState extends State<FlexLayoutPage> {
  List<GlobalKey> _childKeys = [];
  List<Map<String, dynamic>> _childrenInfo = [];

  final _random = Random();
  var _direction = Axis.vertical;
  void _refresh() {
    setState(() {
      _direction =
          _direction == Axis.vertical ? Axis.horizontal : Axis.vertical;
      int childCount = 2 + _random.nextInt(4);
      _childKeys = List.generate(childCount, (index) => GlobalKey());
      _childrenInfo.clear();
    });

    // 延迟获取布局信息，等待渲染完成
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getChildrenInfo();
    });
  }

  void _getChildrenInfo() {
    List<Map<String, dynamic>> info = [];

    for (int i = 0; i < _childKeys.length; i++) {
      final RenderBox? renderBox =
          _childKeys[i].currentContext?.findRenderObject() as RenderBox?;

      if (renderBox != null) {
        final size = renderBox.size;
        final position = renderBox.localToGlobal(Offset.zero);

        info.add({
          'index': i,
          'width': size.width,
          'height': size.height,
          'x': position.dx,
          'y': position.dy,
        });
      }
    }

    setState(() {
      _childrenInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flex研究')),
      body: Column(
        children: [
          SizedBox(width: double.maxFinite),
          Expanded(
            child: ColoredBox(
              color: Colors.blue.shade100,
              child: Stack(
                children: [
                  Flex(
                    direction: _direction,
                    children: List.generate(_childKeys.length, (index) {
                      return _grid('格子$index', 50.0 + _random.nextInt(100),
                          _childKeys[index]);
                    }),
                  ),
                ],
              ),
            ),
          ),
          Text('子组件布局信息', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: _childrenInfo.isEmpty
                ? Text('点击变换按钮获取布局信息')
                : ListView.builder(
                    itemCount: _childrenInfo.length,
                    itemBuilder: (context, index) {
                      final info = _childrenInfo[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          '格子${info['index']}: 尺寸(${info['width']}×${info['height']}) 位置(${info['x']}, ${info['y']})',
                          style: TextStyle(fontSize: 12),
                        ),
                      );
                    },
                  ),
          ),
          TextButton.icon(
            onPressed: _refresh,
            label: Text('变换'),
            icon: Icon(Icons.refresh),
          )
        ],
      ),
    );
  }

  Widget _grid(String title, double size, GlobalKey key) {
    return Container(
      key: key,
      width: size,
      height: size,
      color:
          Colors.accents[title.hashCode % Colors.accents.length].withAlpha(128),
      child: Center(child: Text(title)),
    );
  }
}
