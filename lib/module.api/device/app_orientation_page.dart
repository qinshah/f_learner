import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppOrientationPage extends StatefulWidget {
  const AppOrientationPage({super.key});

  @override
  State<AppOrientationPage> createState() => _AppOrientationPageState();
}

class _AppOrientationPageState extends State<AppOrientationPage> {
  // 存储选中的方向
  Map<DeviceOrientation, bool> orientationSelections = {
    DeviceOrientation.portraitUp: true,
    DeviceOrientation.portraitDown: true,
    DeviceOrientation.landscapeLeft: true,
    DeviceOrientation.landscapeRight: true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('应用方向')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 100),
        children: [
          Text('切换横竖屏'),
          ElevatedButton(
            onPressed: () {
              bool isLandscape =
                  MediaQuery.of(context).orientation == Orientation.landscape;
              if (isLandscape) {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown
                ]);
              } else {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight
                ]);
              }
            },
            child: Text('横屏/竖屏'),
          ),
          SizedBox(height: 20),
          Text('自定义'),
          // 显示所有 DeviceOrientation 值的多选框
          ...orientationSelections.keys.map((DeviceOrientation orientation) {
            return CheckboxListTile(
              title: Text(orientation.toString().split('.')[1]), // 显示枚举名称部分
              value: orientationSelections[orientation],
              onChanged: (bool? newValue) {
                setState(() {
                  orientationSelections[orientation] = newValue ?? false;
                });
              },
            );
          }),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // 获取选中的方向并设置
              List<DeviceOrientation> selectedOrientations = 
                orientationSelections.entries
                  .where((element) => element.value)
                  .map((element) => element.key)
                  .toList();
              
              SystemChrome.setPreferredOrientations(selectedOrientations);
            },
            child: Text('设置方向'),
          ),
        ],
      ),
    );
  }
}