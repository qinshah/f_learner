import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WaterfallLayoutPage extends StatefulWidget {
  const WaterfallLayoutPage({super.key});

  @override
  State<WaterfallLayoutPage> createState() => _WaterfallLayoutPageState();
}

class _WaterfallLayoutPageState extends State<WaterfallLayoutPage> {
  final _aspectRatioCaches = <String, double>{};
  final _imagePaths = <String>[];

  final loadingWidget = const DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.fromBorderSide(
        BorderSide(color: Colors.grey, width: 1),
      ),
    ),
    child: Center(child: CircularProgressIndicator()),
  );

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('AssetManifest.json').then((jsonString) {
      final assets = jsonDecode(jsonString) as Map<String, dynamic>;
      final imagePaths =
          assets.keys.where((String key) => key.contains('images/')).toList();
      // 确保build结束再setState
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _imagePaths.addAll(imagePaths));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('瀑布流(图片)'),
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundImage: const AssetImage(
              'images/5a1b3376ac264e9daf159d205b717a55.jpg',
            ),
          ),
        ),
        actions: const [BackButton()],
      ),
      body: MasonryGridView.count(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: 2,
        // 无限循环显示
        // itemCount为null并使用index对真正数量求模作为下标
        itemCount: _imagePaths.isEmpty ? 0 : null,
        cacheExtent: 2000, // 提前加载2000像素
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        itemBuilder: (context, index) {
          final imagePath = _imagePaths[index % _imagePaths.length];
          final aspectRatio = _aspectRatioCaches[imagePath];
          if (aspectRatio != null) return _buildImage(imagePath, aspectRatio);
          // else在FutureBuilder中获取并保存宽高比
          return FutureBuilder(
            future: _getAndSaveAspectRatio(imagePath),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.hasError) {
                return Icon(Icons.error);
              } else if (asyncSnapshot.hasData) {
                return _buildImage(imagePath, asyncSnapshot.data!);
              }
              // 加载中
              return SizedBox(height: 200, child: loadingWidget);
            },
          );
        },
      ),
    );
  }

  Widget _buildImage(String imagePath, double aspectRatio) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      // 可选，延迟加载图片
      // 解决快速滑动加载大量图片的卡顿
      child: FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 500)),
        builder: (context, asyncSnapshot) {
          final done = asyncSnapshot.connectionState == ConnectionState.done;
          return AspectRatio(
            aspectRatio: aspectRatio, // 固定宽高比解决闪烁问题
            child: done
                ? Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  )
                : loadingWidget,
          );
        },
      ),
    );
  }

  /// 获取图片宽高比
  Future<double> _getAndSaveAspectRatio(String imagePath) async {
    final aspectRatioCompleter = Completer<double>();
    final imageStream = AssetImage(imagePath).resolve(ImageConfiguration.empty);
    final listener = ImageStreamListener((imageInfo, error) {
      if (aspectRatioCompleter.isCompleted) {
        return; // 已完成
      } else {
        aspectRatioCompleter.complete(
          imageInfo.image.width / imageInfo.image.height,
        );
      }
    });
    imageStream.addListener(listener);
    final aspectRatio = await aspectRatioCompleter.future;
    imageStream.removeListener(listener); // 完成后要停止监听
    // TODO 可移除(在debug模式下模拟耗时)
    if (kDebugMode) {
      await Future.delayed(const Duration(seconds: 2));
    }
    // ⚠️重要：保存宽高比以便复用
    _aspectRatioCaches[imagePath] = aspectRatio;
    return aspectRatio;
  }
}
