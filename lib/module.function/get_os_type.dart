import 'package:flutter/material.dart';
import 'package:os_type/os_type.dart';

class GetOSType extends StatefulWidget {
  const GetOSType({super.key});

  @override
  State<GetOSType> createState() => _GetOSTypeState();
}

class _GetOSTypeState extends State<GetOSType> {
  @override
  void initState() {
    super.initState();
    _initHarmonyDeviceType();
  }

  Future<void> _initHarmonyDeviceType() async {
    // 如果是鸿蒙系统，初始化设备类型
    if (OS.isHarmony) {
      try {
        await OS.initHarmonyDeviceType();
      } catch (e) {
        // 错误处理在OS类内部已经完成
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('获取操作系统类型')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '操作系统信息',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('操作系统: ${OS.value.name}'),
            const SizedBox(height: 10),
            Text('是否为Web环境: ${OS.isWebEnv}'),
            const SizedBox(height: 10),
            Text('是否为PC操作系统: ${OS.isPCOS}'),
            const SizedBox(height: 10),
            Text('是否为移动操作系统: ${OS.isMobileOS}'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}