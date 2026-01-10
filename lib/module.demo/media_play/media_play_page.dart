import 'dart:async';
import 'dart:ui';

import 'package:f_learner/module.demo/media_play/media_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MediaPlayPage extends StatefulWidget {
  const MediaPlayPage({super.key});

  @override
  State<MediaPlayPage> createState() => _MediaPlayPageState();
}

class _MediaPlayPageState extends State<MediaPlayPage> {
  final _cntlr = MediaPlayer();

  @override
  void initState() {
    super.initState();
    _cntlr.loadUrlMedia('示例url');
  }

  @override
  void dispose() {
    super.dispose();
    _cntlr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('简单媒体播放')),
      body: ListView(children: [
        ChangeNotifierProvider.value(
          value: _cntlr,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Builder(builder: (context) {
              final isFullScreen =
                  context.select((MediaPlayer p) => p.isFullScreen);
              // 全屏时此页面不播放
              if (isFullScreen) return SizedBox();
              return _PlayerView(cntlr: _cntlr);
            }),
          ),
        ),
        Center(child: Text('下方内容区域'))
      ]),
    );
  }
}

class _PlayerView extends StatefulWidget {
  const _PlayerView({required this.cntlr});

  final MediaPlayer cntlr;

  @override
  State<_PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<_PlayerView> {
  Timer _hubTimer = Timer(Duration.zero, () {});

  // DateTime _lastTapTime = DateTime(0);

  PointerDeviceKind? _lastTapKind;

  @override
  Widget build(BuildContext context) {
    // 比例组件
    return MouseRegion(
      onExit: (_) => setState(() => _hubTimer.cancel()),
      onHover: _onHover,
      child: Stack(
        children: [
          GestureDetector(
            onTapDown: (details) => _lastTapKind = details.kind,
            onDoubleTap: _onDoubleTap,
            onTap: _onTap,
            child: ColoredBox(
              color: Colors.teal.shade100,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('视频区域'),
                  Builder(builder: (context) {
                    final stata = context.select((MediaPlayer c) => c.state);
                    return Text(switch (stata) {
                      MediaPlayerState.loading => '加载中',
                      MediaPlayerState.playing => '播放中',
                      MediaPlayerState.paused => '暂停中',
                      MediaPlayerState.buffering => '缓冲中',
                      // ignore: unreachable_switch_case
                      _ => '播放器出错',
                    });
                  }),
                ],
              )),
            ),
          ),
          if (_hubTimer.isActive)
            _PlayerHub(
              cntlr: widget.cntlr,
              onExitFullScreen: _exitFullScreen,
              onEnterFullScreen: _enterFullScreen,
            ),
        ],
      ),
    );
  }

  void _onHover(_) => _restartHubTimer();

  void _onDoubleTap() {
    //  双击切换全屏
    widget.cntlr.isFullScreen ? _exitFullScreen() : _enterFullScreen();
  }

  void _onTap() {
    // 单击
    if (_lastTapKind == PointerDeviceKind.touch) {
      if (_hubTimer.isActive) {
        setState(() {
          // 隐藏hub
          _hubTimer.cancel();
        });
      } else {
        _restartHubTimer();
      }
    } else {
      // TODO 鼠标单击
      widget.cntlr.togglePlay();
    }
  }

  /// 进入全屏
  void _enterFullScreen() {
    // 设置横屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => Material(
        // 这里还要传递Provider上下文
        child: ChangeNotifierProvider.value(
          value: widget.cntlr,
          child: _PlayerView(cntlr: widget.cntlr),
        ),
      ),
    ))
        .then((_) {
      if (!widget.cntlr.isFullScreen) return;
      // 从全屏退出后应该非全屏
      widget.cntlr.setFullScreenValue(false);
    });
    widget.cntlr.setFullScreenValue(true);
  }

  /// 退出全屏
  void _exitFullScreen() {
    // 取消横屏
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    Navigator.of(context).pop();
    widget.cntlr.setFullScreenValue(false);
  }

  void _restartHubTimer() {
    bool wasHubActive = _hubTimer.isActive;
    _hubTimer.cancel();
    _hubTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          // 隐藏hub
        });
      }
    });
    if (!wasHubActive) {
      setState(() {
        // 显示hub
      });
    }
  }
}

class _PlayerHub extends StatelessWidget {
  const _PlayerHub({
    required this.cntlr,
    required this.onExitFullScreen,
    required this.onEnterFullScreen,
  });

  final MediaPlayer cntlr;

  final VoidCallback onExitFullScreen;

  final VoidCallback onEnterFullScreen;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Builder(builder: (context) {
          final buffering = context.select(
              (MediaPlayer c) => c.state == MediaPlayerState.buffering);
          if (buffering) return _circularProgressIndicator(50);
          return SizedBox.shrink();
        }),
        Positioned(
          left: 0,
          top: 0,
          child: Row(
            children: [
              BackButton(),
              Text('播放器顶部，可以放视频标题'),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // 显示设置
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Builder(builder: (context) {
            final cntlr = context.watch<MediaPlayer>();
            return Row(
              children: [
                IconButton(
                  icon: switch (cntlr.state) {
                    MediaPlayerState.playing => const Icon(Icons.pause),
                    MediaPlayerState.paused => const Icon(Icons.play_arrow),
                    MediaPlayerState.loading => _circularProgressIndicator(20),
                    MediaPlayerState.buffering => _circularProgressIndicator(20),
                    // ignore: unreachable_switch_case
                    _ => const Icon(Icons.error),
                  },
                  onPressed: cntlr.state == MediaPlayerState.playing ||
                          cntlr.state == MediaPlayerState.paused
                      ? cntlr.togglePlay
                      : null,
                ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      cntlr.simulationBuffer(seconds: 5);
                    },
                    child: Text('模拟缓冲5s')),
                if (cntlr.isFullScreen)
                  IconButton(
                    icon: const Icon(Icons.fullscreen_exit),
                    onPressed: onExitFullScreen,
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.fullscreen),
                    onPressed: onEnterFullScreen,
                  ),
              ],
            );
          }),
        )
      ],
    );
  }

  Widget _circularProgressIndicator(double size) {
    return  SizedBox(
      width: size,
      height: size,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
