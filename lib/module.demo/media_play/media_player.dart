import 'package:flutter/material.dart';

class MediaPlayer extends ChangeNotifier {
  MediaPlayerState _state = MediaPlayerState.loading;

  MediaPlayerState get state => _state;

  bool _isFullScreen = false;

  bool get isFullScreen => _isFullScreen;

  void setFullScreenValue(bool value) {
    if (_isFullScreen == value) return;
    notifyListeners();
    _isFullScreen = value;
  }

  double _vullume = 0.5;

  Future<void> loadUrlMedia(String url) async {
    // 执行加载逻辑
    // 模拟加载3s
    await Future.delayed(const Duration(seconds: 3));
    notifyListeners();
    _state = MediaPlayerState.playing;
  }

  void togglePlay({bool? play}) {
    play ??= _state == MediaPlayerState.paused ? true : false;
    notifyListeners();
    if (play) {
      // 执行播放逻辑
      _state = MediaPlayerState.playing;
    } else {
      // 执行暂停逻辑
      _state = MediaPlayerState.paused;
    }
  }

  /// 模拟缓冲
  Future<void> simulationBuffer({int seconds = 2}) async {
    notifyListeners();
    _state = MediaPlayerState.buffering;
    await Future.delayed(Duration(seconds: seconds));
    notifyListeners();
    _state = MediaPlayerState.playing;
  }
}

enum MediaPlayerState {
  /// 初始化中
  loading,

  /// 播放中
  playing,

  /// 已暂停
  paused,

  /// 缓冲中
  buffering,
}
