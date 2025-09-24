import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import '../case/bottom_nav/bottom_nav_page.dart';
import '../case/flame/flame_page.dart';
import '../case/platform_judge/platform_judge_page.dart';
import '../case/platform_view/platform_view_page.dart';
import '../case/quill/quill_page.dart';
import '../case/volume_cntl/volume_cntl_page.dart';
import '../case/open_file/open_file_page.dart';
import '../case/lottie/lottie_page.dart';
import '../case/lens/lens_page.dart';
import '../case/flex_layout/flex_layout_page.dart';


class CasePage extends StatefulWidget {
  const CasePage({super.key});

  @override
  State<CasePage> createState() => _CasePageState();
}

class _CasePageState extends State<CasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _navTile('底部导航', const BottomNavPage()),
                _navTile('Flame 游戏引擎', const FlamePage()),
                _navTile('平台判断', const PlatformJudgePage()),
                // if (UniversalPlatform.isOhos)
                //   _navTile('平台视图（鸿蒙）', const PlatformViewPage()),
                _navTile('音量控制', const VolumeCntlPage()),
                _navTile('打开文件', const OpenFilePage()),
                _navTile('lottie动画', const LottiePage()),
                _navTile('透镜', const LensPage()),
                _navTile('Flex研究', const FlexLayoutPage()),
                _navTile('Quill富文本', const QuillPage()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _navTile(String title, Widget page) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
