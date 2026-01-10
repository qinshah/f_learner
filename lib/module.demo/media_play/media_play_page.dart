import 'dart:async';
import 'dart:ui';

import 'package:f_learner/function/native/harmony_channel.dart';
import 'package:f_learner/module.demo/media_play/media_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:os_type/os_type.dart';
import 'package:provider/provider.dart';

class MediaPlayPage extends StatefulWidget {
  const MediaPlayPage({super.key});

  @override
  State<MediaPlayPage> createState() => _MediaPlayPageState();
}

class _MediaPlayPageState extends State<MediaPlayPage> {
  final _player = MediaPlayer();

  @override
  void initState() {
    super.initState();
    _player.loadUrlMedia('示例url');
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('简单媒体播放')),
      body: ListView(children: [
        ChangeNotifierProvider.value(
          value: _player,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Builder(builder: (context) {
              final isFullScreen =
                  context.select((MediaPlayer p) => p.isFullScreen);
              // 全屏时此页面不播放
              if (isFullScreen) return SizedBox();
              return _PlayerView(player: _player);
            }),
          ),
        ),
        Center(child: Text('下方内容区域'))
      ]),
    );
  }
}

class _PlayerView extends StatefulWidget {
  const _PlayerView({required this.player});

  final MediaPlayer player;

  @override
  State<_PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<_PlayerView> {
  // DateTime _lastTapTime = DateTime(0);

  PointerDeviceKind? _lastTapKind;

  late final player = widget.player;

  @override
  Widget build(BuildContext context) {
    // 比例组件
    return MouseRegion(
      // onExit: (_) => setState(() => _hubTimer.cancel()),
      onHover: (_) => player.reshowHub(),
      child: Stack(
        children: [
          ColoredBox(
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
          Builder(builder: (context) {
            final buffering = context.select(
                (MediaPlayer c) => c.state == MediaPlayerState.buffering);
            if (buffering) {
              return Center(child: const CircularProgressIndicator());
            }
            return SizedBox.shrink();
          }),
          // 触控层
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (details) => _lastTapKind = details.kind,
            onDoubleTap: _onDoubleTap,
            onTap: _onTap,
            child: SizedBox.expand(),
          ),
          Builder(builder: (context) {
            final showHub = context.select((MediaPlayer p) => p.showHub);
            if (!showHub) return SizedBox.shrink();
            return _PlayerHub(
              cntlr: widget.player,
              onEnterFullScreen: _enterFullScreen,
            );
          }),
        ],
      ),
    );
  }

  void _onDoubleTap() {
    //  双击切换全屏
    player.isFullScreen ? Navigator.of(context).maybePop() : _enterFullScreen();
  }

  void _onTap() {
    // 单击
    if (_lastTapKind == PointerDeviceKind.touch) {
      player.toggleHub();
    } else {
      // TODO 鼠标单击
      player.togglePlay();
    }
  }

  /// 进入全屏
  Future<void> _enterFullScreen() async {
    // 设置横屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // 收起状态栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    player.setFullScreenValue(true);
    if (OS.isHarmony) HarmonyChannel.setMiniWindowLandscape(true);
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Material(
        // 这里还要传递Provider上下文
        child: ChangeNotifierProvider.value(
          value: widget.player,
          child: _PlayerView(player: widget.player),
        ),
      ),
    ));
    // 退出后
    if (OS.isHarmony) HarmonyChannel.setMiniWindowLandscape(false);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    if (player.isFullScreen) {
      // 从全屏退出后应该非全屏
      player.setFullScreenValue(false);
    }
  }
}

class _PlayerHub extends StatelessWidget {
  const _PlayerHub({
    required this.cntlr,
    required this.onEnterFullScreen,
  });

  final MediaPlayer cntlr;

  final VoidCallback onEnterFullScreen;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
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
                    MediaPlayerState.loading => _circularProgressIcon(),
                    MediaPlayerState.buffering => _circularProgressIcon(),
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
                  onPressed: cntlr.alwaysShowHub,
                  child: Text('固定Hub'),
                ),
                TextButton(
                  onPressed: () => cntlr.simulationBuffer(seconds: 5),
                  child: Text('模拟缓冲5s'),
                ),
                if (cntlr.isFullScreen)
                  IconButton(
                    icon: const Icon(Icons.fullscreen_exit),
                    onPressed: Navigator.of(context).maybePop,
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

  Widget _circularProgressIcon() {
    return const SizedBox(
      width: 20,
      height: 20,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
