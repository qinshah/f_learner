import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'dart:async';

class OpenFilePage extends StatefulWidget {
  const OpenFilePage({super.key});

  @override
  State<OpenFilePage> createState() => _OpenFilePageState();
}

class _OpenFilePageState extends State<OpenFilePage> {
  var _openResult = 'Unknown';

  Future<void> _openFile() async {
    XFile? file = await openFile();
    final result = await OpenFile.open(file?.path);
    setState(() {
      _openResult = "type=${result.type}  message=${result.message}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('打开文件')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('打开结果: $_openResult\n'),
            TextButton(
              onPressed: _openFile,
              child: Text('打开文件'),
            ),
          ],
        ),
      ),
    );
  }
}
