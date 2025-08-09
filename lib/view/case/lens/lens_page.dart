import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LensPage extends StatefulWidget {
  const LensPage({super.key});

  @override
  State<LensPage> createState() => _LensPageState();
}

class _LensPageState extends State<LensPage> {
  Offset _position = const Offset(100, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('透镜')),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          FlutterLogo(size: 300),
          // 液态玻璃透镜组件
          Positioned(
            left: _position.dx,
            top: _position.dy,
            child: Draggable(
              feedback: GaussianBlur(size: 200),
              childWhenDragging: SizedBox(),
              child: GaussianBlur(size: 200),
              onDragEnd: (details) {
                setState(() {
                  // 应用onDragUpdate的偏移量
                });
              },
              onDragUpdate: (details) => _position += details.delta,
            ),
          ),
        ],
      ),
    );
  }
}

class LiquidGlass extends StatelessWidget {
  final double size;

  const LiquidGlass({
    super.key,
    required this.size,
  });
  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      '''

''',
      width: size,
      height: size,
    );
  }
}

class GaussianBlur extends StatelessWidget {
  final double size;

  const GaussianBlur({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
            Colors.transparent,
          ],
          stops: const [0.0, 0.7, 1.0],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SizedBox(),
        ),
      ),
    );
  }
}
