import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:f_learner/root/root_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});
  final primarySwatch = Colors.teal;

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      colorScheme: ColorScheme.fromSwatch(primarySwatch: primarySwatch),
    );
    return MaterialApp(
      theme: baseTheme.copyWith(
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      darkTheme: baseTheme.copyWith(
        brightness: Brightness.dark,
        colorScheme:
            baseTheme.colorScheme.copyWith(brightness: Brightness.dark),
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
