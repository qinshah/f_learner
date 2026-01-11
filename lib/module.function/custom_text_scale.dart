import 'package:flutter/material.dart';

class CustomTextScale extends StatefulWidget {
  const CustomTextScale({super.key});

  @override
  State<CustomTextScale> createState() => _CustomTextScaleState();
}

class _CustomTextScaleState extends State<CustomTextScale> {
  double _scale = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('自定义字体缩放')),
      body: MediaQuery(
        data: MediaQueryData(
            textScaler: TextScaler.linear(_scale), size: Size(100, 100)),
        child: ListView(
          padding: EdgeInsets.all(6),
          children: [
            Text('只会字体'),
            SizedBox(height: 66),
            Text('缩放：'),
            SliderTheme(
              data: SliderThemeData(
                showValueIndicator: ShowValueIndicator.onDrag,
              ),
              child: Slider(
                value: _scale,
                min: 0.75,
                max: 2,
                label: _scale.toStringAsFixed(2),
                onChanged: (v) => setState(() => _scale = v),
              ),
            ),
            SizedBox(height: 66),
            Text('尺寸100Logo'),
            FlutterLogo(size: 100)
          ],
        ),
      ),
    );
  }
}
