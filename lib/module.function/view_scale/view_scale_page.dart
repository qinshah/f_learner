import 'package:f_learner/module.function/view_scale/scalable_binding.dart';
import 'package:flutter/material.dart';

class ViewScalePage extends StatefulWidget {
  const ViewScalePage({super.key});

  @override
  State<ViewScalePage> createState() => _ViewScalePageState();
}

class _ViewScalePageState extends State<ViewScalePage> {
  double _scale = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('显示缩放')),
      body: MediaQuery(
        data: MediaQueryData(
            textScaler: TextScaler.linear(_scale), size: Size(100, 100)),
        child: ListView(
          padding: EdgeInsets.all(6),
          children: [
            Text('字体缩放，只需设置MediaQueryData的textScaler'),
            SizedBox(height: 10),
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
            Text('显示缩放，需要自定义binding且在main函数替换默认WidgetsFlutterBinding'),
            Text('缩放：'),
            SliderTheme(
              data: SliderThemeData(
                showValueIndicator: ShowValueIndicator.onDrag,
              ),
              child: Slider(
                value: ScalableWidgetsFlutterBinding.ensureInitialized().scale,
                min: 0.75,
                max: 2,
                label: ScalableWidgetsFlutterBinding.ensureInitialized().scale.toStringAsFixed(2),
                onChanged: (v) => setState(() {
                  ScalableWidgetsFlutterBinding.ensureInitialized().setScale(v);
                }),
              ),
            ),
            Text('尺寸100Logo'),
            FlutterLogo(size: 100)
          ],
        ),
      ),
    );
  }
}
