import 'package:flutter/material.dart';

class GetLayoutSize extends StatefulWidget {
  const GetLayoutSize({super.key});

  @override
  State<GetLayoutSize> createState() => _GetLayoutSizeState();
}

class _GetLayoutSizeState extends State<GetLayoutSize> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('获取布局尺寸')),
      body: ColoredBox(
        color: Colors.blue.shade100,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('蓝色区域尺寸：'),
                  // 手动调用宽高，防止release模式不显示Size实例具体尺寸
                  Text('宽:${constraints.maxWidth} 高:${constraints.maxHeight}'),
                  SizedBox(height: 20),
                  Text('应用窗口逻辑尺寸：'),
                  Text('宽:${MediaQuery.of(context).size.width} 高:${MediaQuery.of(context).size.height}'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
