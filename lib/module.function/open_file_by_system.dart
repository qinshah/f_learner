import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class OpenFileBySystem extends StatefulWidget {
  const OpenFileBySystem({super.key});

  @override
  State<OpenFileBySystem> createState() => _OpenFileBySystemState();
}

class _OpenFileBySystemState extends State<OpenFileBySystem> {
  String? _result;

  Future<void> _openFile() async {
    setState(() => _result = null);
    XFile? file = await openFile();
    final result = await OpenFile.open(file?.path);
    setState(() {
      _result = "类型：${result.type}\n信息：${result.message}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('使用系统打开文件')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('选取一个文件后会尝试调用系统打开它'),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _openFile,
              child: Text('选取'),
            ),
            const SizedBox(height: 20),
            Text(_result == null ? '' : '打开结果：\n$_result\n'),
          ],
        ),
      ),
    );
  }
}
