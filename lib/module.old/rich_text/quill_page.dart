import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

class QuillPage extends StatefulWidget {
  const QuillPage({super.key});

  @override
  State<QuillPage> createState() => _QuillPageState();
}

// 实现插入上传后的网络图片
// 一开始最简单的quill，没有图片功能
class _QuillPageState extends State<QuillPage> {
  final _controller = QuillController.basic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quill富文本')),
      body: Column(
        children: [
          QuillSimpleToolbar(
            controller: _controller,
            config: QuillSimpleToolbarConfig(
              // 1、自己加一个按钮
              customButtons: [
                QuillToolbarCustomButtonOptions(
                  onPressed: () => _uploadImage(context),
                  tooltip: '上传图片',
                  icon: const Icon(Icons.image),
                ),
              ],
            ),
          ),
          Expanded(
            // 3、解决报错，需要配置编辑器启用图片
            child: QuillEditor.basic(
              controller: _controller,
              // 主要是配置imageEmbedConfig
              // 需要import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
              config: QuillEditorConfig(
                embedBuilders: FlutterQuillEmbeds.editorBuilders(
                  // 只要imageEmbedConfig不为空就能启用图片了
                  imageEmbedConfig: QuillEditorImageEmbedConfig(
                      // imageProviderBuilder不是必要的，自行配置
                      // imageProviderBuilder: (context, imageUrl) {
                      //   // https://pub.dev/packages/flutter_quill_extensions#-image-assets
                      //   if (imageUrl.startsWith('assets/')) {
                      //     return AssetImage(imageUrl);
                      //   }
                      //   return null;
                      // },
                      ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // 2、实现上传图片的UI和方法等，这里做简单的模拟
  Future<void> _uploadImage(BuildContext context) async {
    // 2.1、弹出对话框，选择图片，这里做简单的模拟
    bool success = await showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('正在上传'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('上传失败或取消'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('上传成功'),
            )
          ],
        );
      },
    );
    // 2.2、如果上传成功，拿到url
    final url = success
        ? 'https://picasso-static.xiaohongshu.com/center_cn4s486641617.png'
        : null;
    if (url == null) return;
    // 2.3、插入图片
    _controller.document.insert(
      _controller.selection.extentOffset, // extentOffset是当前光标位置
      BlockEmbed.image(url),
    );
    // 这里应该是更新光标位置到图片后面
    _controller.updateSelection(
      TextSelection.collapsed(
        offset: _controller.selection.extentOffset + 1,
      ),
      ChangeSource.local,
    );
  }
}
