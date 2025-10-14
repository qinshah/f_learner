import 'dart:io';

import 'package:flutter/material.dart';

class EnvVariablesPage extends StatelessWidget {
  const EnvVariablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final envs = Platform.environment.entries.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('环境变量'),
      ),
      body: ListView.builder(
        itemCount: envs.length,
        itemBuilder: (context, index) {
          final env = envs[index];
          return ListTile(
            title: Text(env.key),
            subtitle: Text(env.value),
          );
        },
      ),
    );
  }
}
