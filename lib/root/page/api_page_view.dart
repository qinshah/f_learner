import 'package:f_learner/data_model/page_model.dart';
import 'package:f_learner/module.old/env_variables/env_variables_page.dart';
import 'package:f_learner/module.old/platform_judge/platform_judge_page.dart';
import 'package:f_learner/module.old/process/process_page.dart';
import 'package:f_learner/root/category_widget.dart';
import 'package:flutter/material.dart';

class ApiPageView extends StatelessWidget {
  const ApiPageView({super.key});


  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        CategoryWidget(name: '系统', pages: [
          PageModel3('环境变量', const EnvVariablesPage()),
          PageModel3('进程(模拟终端)', const ProcessPage()),
          PageModel3('系统和平台判断', const PlatformJudgePage()),
        ]),
      ],
    );
  }
}