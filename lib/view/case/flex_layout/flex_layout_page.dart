import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FlexLayoutPage extends StatefulWidget {
  const FlexLayoutPage({super.key});

  @override
  State<FlexLayoutPage> createState() => _FlexLayoutPageState();
}

class _FlexLayoutPageState extends State<FlexLayoutPage> {
  List<Map<String, dynamic>> _childrenInfo = [];
  final _random = Random();
  var _direction = Axis.vertical;
  int _childCount = 3;
  List<double> _childSizes = [];

  @override
  void initState() {
    super.initState();
    _generateChildSizes();
  }

  void _generateChildSizes() {
    _childSizes =
        List.generate(_childCount, (index) => 50.0 + _random.nextInt(100));
  }

  void _refresh() {
    setState(() {
      _direction =
          _direction == Axis.vertical ? Axis.horizontal : Axis.vertical;
      _childCount = 2 + _random.nextInt(4);
      _generateChildSizes();
    });
  }

  void _onLayoutUpdate(List<Map<String, dynamic>> info) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _childrenInfo = info;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flex研究 - 继承RenderFlex (超简单)')),
      body: Column(
        children: [
          // 主要布局区域
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.blue.shade50,
              padding: EdgeInsets.all(16),
              child: FlexBar(
                direction: _direction,
                onLayoutUpdate: _onLayoutUpdate,
                children: List.generate(_childCount, (index) {
                  return _buildChild('格子$index', _childSizes[index], index);
                }),
              ),
            ),
          ),

          // 信息面板
          Container(
            height: 200,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('方向: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(_direction == Axis.vertical ? '垂直' : '水平'),
                    Spacer(),
                    Text('数量: $_childCount'),
                  ],
                ),
                SizedBox(height: 8),
                Expanded(
                  child: _childrenInfo.isEmpty
                      ? Center(child: Text('布局信息加载中...'))
                      : ListView.builder(
                          itemCount: _childrenInfo.length,
                          itemBuilder: (context, index) {
                            final info = _childrenInfo[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: 4),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(
                                '格子${info['index']}: ${info['width'].toStringAsFixed(0)}×${info['height'].toStringAsFixed(0)} 位置(${info['x'].toStringAsFixed(0)}, ${info['y'].toStringAsFixed(0)})',
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),

          // 控制按钮
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _refresh,
                  child: Text('变换方向'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _generateChildSizes();
                    });
                  },
                  child: Text('随机尺寸'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChild(String title, double size, int index) {
    return Container(
      width: size,
      height: size,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.accents[index % Colors.accents.length].withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text('${size.toInt()}',
                style: TextStyle(color: Colors.white70, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

class FlexBar extends Flex {
  final Function onLayoutUpdate;

  const FlexBar({
    super.key,
    required super.direction,
    required this.onLayoutUpdate,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.clipBehavior,
    super.spacing,
    super.children,
  });

  @override
  RenderFlex createRenderObject(BuildContext context) {
    return RenderFlexBar(
      onLayoutUpdate: onLayoutUpdate,
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: getEffectiveTextDirection(context),
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
      spacing: spacing,
    );
  }
}

class RenderFlexBar extends RenderFlex {
  Function onLayoutUpdate;

  RenderFlexBar({
    required this.onLayoutUpdate,
    super.children,
    super.direction,
    super.mainAxisSize,
    super.mainAxisAlignment,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.clipBehavior,
    super.spacing,
  });

  @override
  void performLayout() {
    // 1. 调用父类布局 - 保持完整的Flex布局逻辑
    super.performLayout();

    // 2. 布局完成后，直接收集子组件信息
    _collectChildrenInfo();
  }

  void _collectChildrenInfo() {
    List<Map<String, dynamic>> info = [];

    RenderBox? child = firstChild;
    int index = 0;

    // 遍历所有子组件，获取布局信息
    while (child != null) {
      final FlexParentData childParentData = child.parentData as FlexParentData;

      info.add({
        'index': index,
        'width': child.size.width,
        'height': child.size.height,
        'x': childParentData.offset.dx,
        'y': childParentData.offset.dy,
        'flex': childParentData.flex ?? 0,
        'fit': childParentData.fit.toString(),
      });

      child = childParentData.nextSibling;
      index++;
    }

    // 3. 通知上层更新
    onLayoutUpdate(info);
  }
}
