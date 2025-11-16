import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:os_type/os_type.dart';

import 'root/root_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化鸿蒙设备类型
  if (OS.isHarmony) await OS.initHarmonyDeviceType();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final primarySwatch = Colors.teal;
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade100,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primarySwatch),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primarySwatch,
          brightness: Brightness.dark,
        ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
        AppFlowyEditorLocalizations.delegate,
      ],
      // 含中文
      supportedLocales: AppFlowyEditorLocalizations.delegate.supportedLocales,
      home: const RootView(),
    );
  }
}
