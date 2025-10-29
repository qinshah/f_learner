import 'dart:math';
import 'package:flutter/material.dart';

class InfiniteCanvas2 extends StatefulWidget {
  const InfiniteCanvas2({super.key});

  @override
  State<InfiniteCanvas2> createState() => _InfiniteCanvas2State();
}

class _InfiniteCanvas2State extends State<InfiniteCanvas2> {
  Offset _topLeft = Offset.zero;
  double _scale = 1.0; // 当前缩放比例
  double _lastScale = 1.0; // 缩放开始时的缩放比例
  Offset _lastTopLeft = Offset.zero;
  final double _minScale = 0.5; // 最小缩放比例
  final double _maxScale = 3.0; // 最大缩放比例
  late final _offsets = _randomOffets();

  final _random = Random();

  Offset _lastLogicFocalOffset = Offset.zero;

  void _resetView() {
    setState(() {
      _topLeft = Offset.zero;
      _scale = 1.0;
    });
  }

  void _onScaleStart(ScaleStartDetails details) {
    _lastScale = _scale;
    _lastTopLeft = _topLeft;
    _lastLogicFocalOffset = details.localFocalPoint / _lastScale;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(
      () {
        _scale = (_lastScale + details.scale - 1).clamp(_minScale, _maxScale);
        final dS = _scale - _lastScale;
        _topLeft = _lastTopLeft + (_lastLogicFocalOffset * dS);
        // _topLeft -= details.focalPointDelta;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('无限画布2'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetView,
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onScaleStart: _onScaleStart,
          onScaleUpdate: _onScaleUpdate,
          child: Stack(
            children: [
              // (0, 0)
              Positioned(
                top: 0 * _scale - _topLeft.dy,
                left: 0 * _scale - _topLeft.dx,
                child: Transform.scale(
                  alignment: Alignment.topLeft,
                  scale: _scale,
                  child: ColoredBox(color: Colors.grey, child: Text('(0, 0)')),
                ),
              ),
              for (final offset in _offsets) _buildPoint(offset),
              // 显示视口坐标信息
              Positioned(
                top: 10,
                left: 10,
                child: Text(
                  '(${_topLeft.dx.toStringAsFixed(1)}, ${_topLeft.dy.toStringAsFixed(1)})',
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  List<Offset> _randomOffets([int count = 25]) {
    return List.generate(count, (_) {
      return Offset(
        _random.nextDouble() * 500,
        _random.nextDouble() * 500,
      );
    });
  }

  Widget _buildPoint(Offset offset) {
    return _Point(
      key: ValueKey(offset),
      topLeft: _topLeft,
      initOffset: offset,
      scale: _scale,
      onSelected: () => setState(() {
        _offsets.add(offset);
        _offsets.remove(offset);
      }),
    );
  }
}

class _Point extends StatefulWidget {
  const _Point({
    required this.initOffset,
    required this.onSelected,
    required this.scale,
    required this.topLeft,
    super.key,
  });

  final Offset topLeft;

  final Offset initOffset;

  final VoidCallback onSelected;

  final double scale;

  @override
  State<_Point> createState() => _PointState();
}

class _PointState extends State<_Point> {
  late Offset _offset = widget.initOffset;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      // 越放大，逻辑距离越大
      top: _offset.dy * widget.scale - widget.topLeft.dy,
      left: _offset.dx * widget.scale - widget.topLeft.dx,
      child: Transform.scale(
        scale: widget.scale,
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onPanDown: (_) => widget.onSelected(),
          onPanUpdate: (details) => setState(() => _offset += details.delta),
          child: Card(
            color: Colors.primaries[hashCode % Colors.primaries.length],
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: widget.onSelected,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  '${_offset.dx.toStringAsFixed(2)},${_offset.dy.toStringAsFixed(2)}',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
