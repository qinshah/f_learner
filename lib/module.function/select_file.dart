import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

class SelectFile extends StatefulWidget {
  const SelectFile({super.key});

  @override
  State<SelectFile> createState() => _SelectFileState();
}

class _SelectFileState extends State<SelectFile> {
  /// 是否多选
  bool _multiSelect = false;
  List<String?> _selectedPaths = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('选取文件/文件夹')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('多选'),
              Switch(
                value: _multiSelect,
                onChanged: (v) => setState(() => _multiSelect = v),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text('选取文件'),
            onPressed: () async {
              if (!_multiSelect) {
                final file = await openFile();
                setState(() => _selectedPaths = [file?.path]);
                return;
              } // else
              final files = await openFiles();
              setState(() {
                _selectedPaths = files.map((e) => e.path).toList();
              });
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text('选取文件夹'),
            onPressed: () async {
              final paths = _multiSelect
                  ? await getDirectoryPaths()
                  : [await getDirectoryPath()];
              setState(() => _selectedPaths = paths);
            },
          ),
          const SizedBox(height: 20),
          for (int i = 0; i < _selectedPaths.length; i++)
            ListTile(
              title: Text('${i + 1}'),
              subtitle: Text(_selectedPaths[i].toString()),
            )
        ],
      ),
    );
  }
}
