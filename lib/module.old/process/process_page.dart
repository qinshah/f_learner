import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({super.key});

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  final _outputs = <String>[];
  String _inputText = '';
  final _terminalEnv = Platform.environment['SHELL'] ?? 'bash';

  Future<void> _runCommand() async {
    _outputs.clear();
    try {
      final process = await Process.start(_terminalEnv, ['-c', _inputText]);
      process.stdout.transform(utf8.decoder).listen((line) {
        setState(() => _outputs.add(line));
      });
      process.stderr.transform(utf8.decoder).listen((line) {
        setState(() => _outputs.add(line));
      });
      process.exitCode.then((code) {
        setState(() => _outputs.add('退出码: $code'));
      });
    } catch (e) {
      setState(() => _outputs.add('无法运行，错误信息: $e'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('进程(模拟终端)')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            onChanged: (text) => setState(() => _inputText = text),
            maxLines: null,
            decoration: InputDecoration(
              hintText: '输入命令',
              border: OutlineInputBorder(),
              // 回车图标
              suffixIcon: IconButton(
                icon: Icon(Icons.keyboard_return_rounded),
                onPressed: _inputText.isEmpty ? null : _runCommand,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [SelectableText(_outputs.join('\n'))],
          ),
        ),
      ]),
    );
  }
}


// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:re_editor/re_editor.dart';

// class ProcessPage extends StatefulWidget {
//   const ProcessPage({super.key});

//   @override
//   State<ProcessPage> createState() => _ProcessPageState();
// }

// class _ProcessPageState extends State<ProcessPage> {
//   final _controller = CodeLineEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('进程(模拟终端)'),
//         bottom: const PreferredSize(
//           preferredSize: Size.fromHeight(1),
//           child: Divider(height: 1, thickness: 1),
//         ),
//       ),
//       body: Focus(
//         onKeyEvent: (_, event) {
//           if(event is KeyUpEvent && event.logicalKey == LogicalKeyboardKey.enter){
            
//           }
//           return KeyEventResult.ignored;
//         },
//         child: CodeEditor(
//           controller: _controller,
//           wordWrap: false,
//         ),
//       ),
//     );
//   }
// }
