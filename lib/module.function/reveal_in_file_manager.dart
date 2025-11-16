import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:os_type/os_type.dart';
import 'package:show_in_file_manager/show_in_file_manager.dart';

// 鸿蒙平台支持
import 'package:open_file_ohos/open_file_ohos.dart';

class RevealInFileManager extends StatefulWidget {
  const RevealInFileManager({super.key});

  @override
  State<RevealInFileManager> createState() => _RevealInFileManagerState();
}

class _RevealInFileManagerState extends State<RevealInFileManager> {
  String? _result;
  String? _selectedPath;

  Future<void> _selectAndRevealFile() async {
    setState(() {
      _result = null;
      _selectedPath = null;
    });
    
    // 选择文件
    XFile? file = await openFile();
    if (file == null) return;
    
    setState(() {
      _selectedPath = file.path;
    });
    
    await _revealPath(file.path);
  }

  Future<void> _selectAndRevealDirectory() async {
    setState(() {
      _result = null;
      _selectedPath = null;
    });
    
    // 选择文件夹
    String? directoryPath = await getDirectoryPath();
    if (directoryPath == null) return;
    
    setState(() {
      _selectedPath = directoryPath;
    });
    
    await _revealPath(directoryPath);
  }

  Future<void> _revealPath(String path) async {
    try {
      // 检查平台是否支持
      if (OS.isWebEnv) {
        setState(() {
          _result = "Web环境不支持此功能";
        });
        return;
      }
      
      // 鸿蒙平台特殊处理
      if (OS.isHarmony) {
        // 在鸿蒙平台上，我们尝试使用open_file_ohos打开文件所在目录
        // 获取文件所在目录路径
        final directoryPath = path.substring(0, path.lastIndexOf('/'));
        final result = await OpenFile.open(directoryPath);
        setState(() {
          _result = "在鸿蒙平台上打开文件所在目录: $directoryPath\n结果: ${result.message}";
        });
        return;
      }
      
      // 目前show_in_file_manager只支持Windows和macOS
      if (!OS.isWindows && !OS.isMacOS) {
        setState(() {
          _result = "当前平台不支持此功能，仅支持Windows、macOS和鸿蒙系统";
        });
        return;
      }
      
      // 调用显示文件管理器的函数
      await showInFileManager(path);
      setState(() {
        _result = "成功在文件管理器中显示: $path";
      });
    } catch (e) {
      setState(() {
        _result = "操作失败: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('在文件管理器中显示')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('选择一个文件或文件夹后会在文件管理器中显示其位置'),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _selectAndRevealFile,
              child: const Text('选择文件并显示'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _selectAndRevealDirectory,
              child: const Text('选择文件夹并显示'),
            ),
            const SizedBox(height: 20),
            if (_selectedPath != null) 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('选中的路径:\n$_selectedPath', 
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            const SizedBox(height: 20),
            if (_result != null) 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('操作结果:\n$_result', 
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}