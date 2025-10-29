import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Quad;

class InfiniteCanvas3 extends StatefulWidget {
  const InfiniteCanvas3({super.key});

  @override
  State<InfiniteCanvas3> createState() => _InfiniteCanvas3State();
}

class _InfiniteCanvas3State extends State<InfiniteCanvas3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('无限画布3')),
      body: InteractiveViewerBuilder(),
    );
  }
}

class InteractiveViewerBuilder extends StatelessWidget {
  const InteractiveViewerBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    // 结论：在视口中的组件一旦viewport改变就会重新构建
    return InteractiveViewer.builder(
      minScale: 0.1,
      boundaryMargin: const EdgeInsets.all(2000),
      builder: (BuildContext context, Quad viewport) {
        return ColoredBox(
          color: Colors.grey,
          child: Stack(
            children: [
              SizedBox(
                width: 2000,
                height: 2000,
              ),
              Positioned(
                top: 1000,
                left: 1000,
                child: TextButton(onPressed: () {}, child: Text('0, 0')),
              ),
            ],
          ),
        );
      },
    );
  }
}
