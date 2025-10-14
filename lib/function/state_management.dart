import 'package:flutter/foundation.dart';

abstract class LogicNotifier extends ChangeNotifier {
  @override
  void dispose() {
    super.dispose();
    rememberDispose();
  }

  void rememberDispose();
}
