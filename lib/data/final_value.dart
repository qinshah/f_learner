import 'package:flutter/foundation.dart';

abstract class FinalValue {
  static final runInMobile = switch (defaultTargetPlatform) {
    TargetPlatform.android || TargetPlatform.iOS => true,
    _ => false
  };
}
