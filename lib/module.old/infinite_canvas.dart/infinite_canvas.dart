import 'dart:math';

import 'package:flutter/material.dart';

class InfiniteCanvas extends StatefulWidget {
  const InfiniteCanvas({super.key});

  @override
  State<InfiniteCanvas> createState() => _InfiniteCanvasState();
}

class _InfiniteCanvasState extends State<InfiniteCanvas> {
  Offset _topLeft = Offset.zero;
  double _scale = 1;
  double _startScale = 1;
  final _minScale = 0.5;
  final _maxScale = 5;
  final _random = Random();
  late List<Offset> _offsets = _randomOffets();
  Size _canvasSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('无限画布')),
      body: LayoutBuilder(builder: (context, constraints) {
        _canvasSize = constraints.biggest / _minScale;
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              width: _canvasSize.width,
              height: _canvasSize.height,
              child: Transform.scale(
                scale: _scale,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onScaleUpdate: (details) => setState(() {
                    _topLeft += details.focalPointDelta;
                    _scale = (_startScale + details.scale - 1)
                        .clamp(_minScale, _maxScale)
                        .toDouble();
                  }),
                  onScaleStart: (_) => _startScale = _scale,
                  child: Stack(
                    children: [
                      Positioned(
                        top: _topLeft.dy,
                        left: _topLeft.dx,
                        child: Card(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.all(6),
                              child: Text('左上角原点'),
                            ),
                          ),
                        ),
                      ),
                      for (final offset in _offsets) _buildOffsetItem(offset),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              child: Card(
                color: Colors.teal.shade300,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    setState(() => _offsets = _randomOffets());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text('随机刷新'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => setState(() {
                  _topLeft = Offset.zero;
                  _scale = 1;
                }),
              ),
            ),
          ],
        );
      }),
    );
  }

  List<Offset> _randomOffets([int count = 25]) {
    return List.generate(count, (_) {
      return Offset(
        _random.nextDouble() * _canvasSize.width,
        _random.nextDouble() * _canvasSize.height,
      );
    });
  }

  Widget _buildOffsetItem(Offset offset) {
    return _Point(
      key: ValueKey(offset),
      topLeft: _topLeft,
      initOffset: offset,
      onSelected: () {
        _offsets.remove(offset);
        setState(() {
          _offsets.add(offset);
        });
      },
    );
  }
}

class _Point extends StatefulWidget {
  const _Point({
    required this.topLeft,
    required this.initOffset,
    required this.onSelected,
    super.key,
  });

  final Offset topLeft;
  final Offset initOffset;

  final VoidCallback onSelected;

  @override
  State<_Point> createState() => _PointState();
}

class _PointState extends State<_Point> {
  late Offset _offset = widget.initOffset;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _offset.dy + widget.topLeft.dy,
      left: _offset.dx + widget.topLeft.dx,
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
    );
  }
}
