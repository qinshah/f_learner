import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WordLayoutPage extends StatefulWidget {
  const WordLayoutPage({super.key});

  @override
  State<WordLayoutPage> createState() => _WordLayoutPageState();
}

class _WordLayoutPageState extends State<WordLayoutPage> {
  final _pageWidth = 210.0;
  final _pageHeight = 297.0;
  bool _ctrlPressed = false;
  int _pointerCount = 0;

  final _listViewCntlr = ScrollController();

  final _iVCntlr = TransformationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Word布局尝试'), actions: [
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            _iVCntlr.value = Matrix4.identity();
          },
        ),
        IconButton(
          icon: Icon(Icons.vertical_align_top),
          onPressed: () {
            _listViewCntlr.animateTo(0,
                duration: Durations.medium1, curve: Curves.ease);
          },
        ),
      ]),
      body: LayoutBuilder(builder: (context, constraints) {
        return InteractiveViewer.builder(
          boundaryMargin: EdgeInsets.all(double.infinity),
          transformationController: _iVCntlr,
          maxScale: 10,
          scaleEnabled: _getScaleEnabled(),
          panEnabled: false,
          onInteractionUpdate: (details) {
            if (details.pointerCount == 1) {
              _updateTransform(details);
            }
            if (_pointerCount != details.pointerCount) {
              setState(() {
                _pointerCount = details.pointerCount;
              });
            }
          },
          builder: (context, viewport) {
            return ColoredBox(
              color: Colors.black12,
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Center(
                  child: SizedBox(
                    width: _pageWidth,
                    child: ListView.builder(
                      controller: _listViewCntlr,
                      physics: const NeverScrollableScrollPhysics(),
                      // physics: _getScaleEnabled()
                      //     ? const NeverScrollableScrollPhysics()
                      //     : null,
                      padding: const EdgeInsets.all(6),
                      itemBuilder: (context, index) {
                        final mColor =
                            Colors.primaries[index % Colors.primaries.length];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: ColoredBox(
                              color: mColor.shade100, child: _buildPage(index)),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_listenCtrl);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_listenCtrl);
    super.dispose();
  }

  bool _listenCtrl(KeyEvent event) {
    final isCtrlPressed = HardwareKeyboard.instance.isControlPressed;
    if (_ctrlPressed != isCtrlPressed) {
      setState(() {
        _ctrlPressed = isCtrlPressed;
      });
    }
    return isCtrlPressed ? true : false;
  }

  bool _getScaleEnabled() {
    return _ctrlPressed || _pointerCount > 1;
  }

  void _updateTransform(ScaleUpdateDetails details) {
    final curTransform = _iVCntlr.value;
    final curScale = curTransform.getMaxScaleOnAxis();
    final maxListViewY = _listViewCntlr.position.maxScrollExtent;
    final curListViewY = _listViewCntlr.position.pixels;
    double newListViewY = curListViewY + details.focalPointDelta.dx / curScale;
    final bool listViewAtTopOrBottom;
    if (newListViewY < 0 || newListViewY > maxListViewY) {
      listViewAtTopOrBottom = true;
    } else {
      listViewAtTopOrBottom = false;
      _listViewCntlr
          .jumpTo(curListViewY - details.focalPointDelta.dy / curScale);
    }
    // 使用_iVCntlr更新InteractiveViewer的水平Transform
    final newTransform = curTransform.clone();
    newTransform.translate(
      details.focalPointDelta.dx / curScale,
      listViewAtTopOrBottom ? details.focalPointDelta.dy / curScale : 0,
    );
    _iVCntlr.value = newTransform;
  }

  Widget _buildPage(int index) {
    return AspectRatio(
      aspectRatio: _pageWidth / _pageHeight,
      child: Center(child: Text('第${index + 1}页')),
    );
  }
}
