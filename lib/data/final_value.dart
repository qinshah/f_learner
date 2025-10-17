import 'package:flutter/foundation.dart';

abstract class FinalValue {
  static final runInAndroidIos = switch (defaultTargetPlatform) {
    TargetPlatform.android || TargetPlatform.iOS => true,
    _ => false
  };
}
