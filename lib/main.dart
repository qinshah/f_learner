import 'package:f_learner/app/app_view.dart';
import 'package:f_learner/module.function/view_scale/scalable_binding.dart';
import 'package:flutter/material.dart';
import 'package:os_type/os_type.dart';


Future<void> main() async {
  ScalableWidgetsFlutterBinding.ensureInitialized();
  // 初始化鸿蒙设备类型
  if (OS.isHarmony) await OS.initHarmonyDeviceType();
  runApp(const AppView());
}
