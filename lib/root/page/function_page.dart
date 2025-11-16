import 'package:f_learner/data_model/page_model.dart';
import 'package:f_learner/module.function/select_file.dart';
import 'package:f_learner/module.function/open_file_by_system.dart';
import 'package:f_learner/module.function/reveal_in_file_manager.dart';
import 'package:flutter/material.dart';

import '../category_widget.dart';

class FunctionPage extends StatelessWidget {
  const FunctionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        CategoryWidget(name: '设备', pages: [
          // PageModel3('操作系统类型', GetOSType()),
        ]),
        CategoryWidget(name: '文件管理', pages: [
          PageModel3('选取文件/文件夹', SelectFile()),
          PageModel3('在文件管理器中显示', RevealInFileManager()),
          PageModel3('使用系统打开文件', OpenFileBySystem()),
        ]),
        CategoryWidget(name: '本地存储', pages: []),
      ],
    );
  }
}
