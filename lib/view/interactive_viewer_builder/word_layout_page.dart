import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

class WordLayoutPage extends StatefulWidget {
  const WordLayoutPage({super.key});

  @override
  State<WordLayoutPage> createState() => _WordLayoutPageState();
}

class _WordLayoutPageState extends State<WordLayoutPage> {
  final _pageWidth = 210.0;
  final _pageHeight = 297.0;
  final _minScale = 0.2;
  bool _ctrlPressed = false;
  bool _shiftPressed = false;
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
        final viewPortHeight = constraints.maxHeight / _minScale / 1.2;
        return Listener(
          onPointerSignal: _handlePointerSignal,
          child: InteractiveViewer.builder(
            boundaryMargin: EdgeInsets.all(double.infinity),
            transformationController: _iVCntlr,
            maxScale: 10,
            minScale: _minScale,
            scaleEnabled: _getScaleEnabled(),
            panEnabled: false,
            onInteractionUpdate: (details) {
              if (details.pointerCount == 1) {
                _updateTransform(details.focalPointDelta);
              }
              if (_pointerCount != details.pointerCount) {
                setState(() {
                  _pointerCount = details.pointerCount;
                });
              }
            },
            builder: (context, viewport) {
              return Container(
                color: Colors.black12,
                // 视口尺寸
                width: _pageWidth * 2,
                height: viewPortHeight,
                child: ListView.builder(
                  controller: _listViewCntlr,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(2),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Center(child: _buildPage(index)),
                    );
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_listenKeyBoard);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_listenKeyBoard);
    super.dispose();
  }

  bool _listenKeyBoard(KeyEvent event) {
    _shiftPressed = HardwareKeyboard.instance.isShiftPressed;
    final isCtrlPressed = HardwareKeyboard.instance.isControlPressed;
    if (_ctrlPressed != isCtrlPressed) {
      setState(() {
        _ctrlPressed = isCtrlPressed;
      });
      if (isCtrlPressed) return true;
    }
    return false;
  }

  bool _getScaleEnabled() {
    return _ctrlPressed || _pointerCount > 1;
  }

  // 添加鼠标滚轮处理方法
  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      if (_ctrlPressed) return; // 在缩放
      final curTransform = _iVCntlr.value;
      final curScale = curTransform.getMaxScaleOnAxis();
      // 根据是否按了Shift键来决定操作哪个控制器
      if (_shiftPressed) {
        // 按了Shift键，操作_iVCntlr（水平滚动）
        final newTransform = curTransform.clone();
        // 根据滚动方向进行水平平移
        newTransform.translate(-event.scrollDelta.dy / curScale);
        _iVCntlr.value = newTransform;
      } else {
        // 没有按Shift键，操作_listViewCntlr（垂直滚动）
        final curListViewY = _listViewCntlr.position.pixels;
        final maxListViewY = _listViewCntlr.position.maxScrollExtent;
        final newListViewY = (curListViewY + event.scrollDelta.dy / curScale)
            .clamp(0.0, maxListViewY);
        _listViewCntlr.jumpTo(newListViewY);
      }
    }
  }

  void _updateTransform(Offset dp, [bool horizontal = true]) {
    final curTransform = _iVCntlr.value;
    final curScale = curTransform.getMaxScaleOnAxis();
    final maxListViewY = _listViewCntlr.position.maxScrollExtent;
    final curListViewY = _listViewCntlr.position.pixels;
    double newListViewY = curListViewY + dp.dx / curScale;
    final bool listViewAtTopOrBottom;
    if (newListViewY < 0 || newListViewY > maxListViewY) {
      listViewAtTopOrBottom = true;
    } else {
      listViewAtTopOrBottom = false;
      _listViewCntlr.jumpTo(curListViewY - dp.dy / curScale);
    }
    // 使用_iVCntlr更新InteractiveViewer的水平Transform
    final newTransform = curTransform.clone();
    newTransform.translate(
      horizontal ? dp.dx / curScale : 0,
      listViewAtTopOrBottom ? dp.dy / curScale : 0,
    );
    _iVCntlr.value = newTransform;
  }

  Widget _buildPage(int index) {
    final mColor = Colors.primaries[index % Colors.primaries.length];
    return Container(
      color: mColor.shade100,
      width: _pageWidth,
      height: _pageHeight,
      child: Center(
        child: Text('第${index + 1}页'),
      ),
    );
  }
}
