import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Quad, Vector3;

class InteractiveViewerBuilder extends StatefulWidget {
  const InteractiveViewerBuilder({super.key});

  @override
  State<InteractiveViewerBuilder> createState() =>
      _InteractiveViewerBuilderState();
}

class _InteractiveViewerBuilderState extends State<InteractiveViewerBuilder> {
  static const double _cellWidth = 160.0;
  static const double _cellHeight = 80.0;

  // Returns the axis aligned bounding box for the given Quad, which might not
  // be axis aligned.
  Rect _axisAlignedBoundingBox(Quad quad) {
    double xMin = quad.point0.x;
    double xMax = quad.point0.x;
    double yMin = quad.point0.y;
    double yMax = quad.point0.y;
    for (final Vector3 point in <Vector3>[
      quad.point1,
      quad.point2,
      quad.point3
    ]) {
      if (point.x < xMin) {
        xMin = point.x;
      } else if (point.x > xMax) {
        xMax = point.x;
      }

      if (point.y < yMin) {
        yMin = point.y;
      } else if (point.y > yMax) {
        yMax = point.y;
      }
    }

    return Rect.fromLTRB(xMin, yMin, xMax, yMax);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InteractiveViewerBuilder'),
      ),
      body: Center(
        child: InteractiveViewer.builder(
          boundaryMargin: const EdgeInsets.all(double.infinity),
          builder: (BuildContext context, Quad viewport) {
            return _TableBuilder(
              cellWidth: _cellWidth,
              cellHeight: _cellHeight,
              viewport: _axisAlignedBoundingBox(viewport),
              builder: (BuildContext context, int row, int column) {
                return _Item(
                  cellHeight: _cellHeight,
                  cellWidth: _cellWidth,
                  row: row,
                  column: column,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _Item extends StatefulWidget {
  const _Item({
    required this.cellHeight,
    required this.cellWidth,
    required this.row,
    required this.column,
  });

  final double cellHeight;
  final double cellWidth;

  final int row;
  final int column;

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  int _buildCounter = 0;
  @override
  Widget build(BuildContext context) {
    print('第${widget.row}行 ${widget.column}列第${++_buildCounter}次构建}');
    return Container(
      height: widget.cellHeight,
      width: widget.cellWidth,
      color: widget.row % 2 + widget.column % 2 == 1
          ? Colors.white
          : Colors.grey.shade300,
      child: Align(child: Text('${widget.row} x ${widget.column}')),
    );
  }
}

typedef _CellBuilder = Widget Function(
    BuildContext context, int row, int column);

class _TableBuilder extends StatelessWidget {
  const _TableBuilder({
    required this.cellWidth,
    required this.cellHeight,
    required this.viewport,
    required this.builder,
  });

  final double cellWidth;
  final double cellHeight;
  final Rect viewport;
  final _CellBuilder builder;

  @override
  Widget build(BuildContext context) {
    final int firstRow = (viewport.top / cellHeight).floor();
    final int lastRow = (viewport.bottom / cellHeight).ceil();
    final int firstCol = (viewport.left / cellWidth).floor();
    final int lastCol = (viewport.right / cellWidth).ceil();

    // This will create and render exactly (lastRow - firstRow) * (lastCol - firstCol) cells

    return SizedBox(
      // Stack needs constraints, even though we then Clip.none outside of them.
      // InteractiveViewer.builder always sets constrained to false, giving infinite constraints to the child.
      // See: https://api.flutter.dev/flutter/widgets/InteractiveViewer/constrained.html
      width: 1,
      height: 1,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          for (int row = firstRow; row < lastRow; row++)
            for (int col = firstCol; col < lastCol; col++)
              Positioned(
                left: col * cellWidth,
                top: row * cellHeight,
                child: builder(context, row, col),
              ),
        ],
      ),
    );
  }
}
