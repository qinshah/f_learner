import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SafeAreaPage extends StatefulWidget {
  const SafeAreaPage({super.key});

  @override
  State<SafeAreaPage> createState() => _SafeAreaPageState();
}

class _SafeAreaPageState extends State<SafeAreaPage> {
  bool _left = false;
  bool _right = false;
  bool _top = false;
  bool _bottom = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: _left,
      right: _right,
      top: _top,
      bottom: _bottom,
      child: Scaffold(
        appBar: AppBar(title: Text('安全区域')),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: [
            Text('Safe Area 边距设置'),
            CheckboxListTile(
              title: Text('左侧 (left)'),
              value: _left,
              onChanged: (bool? value) {
                setState(() {
                  _left = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('右侧 (right)'),
              value: _right,
              onChanged: (bool? value) {
                setState(() {
                  _right = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('顶部 (top)'),
              value: _top,
              onChanged: (bool? value) {
                setState(() {
                  _top = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('底部 (bottom)'),
              value: _bottom,
              onChanged: (bool? value) {
                setState(() {
                  _bottom = value ?? false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
// TODO Implement this library.