import 'package:flutter/material.dart';

class FlexPage extends StatefulWidget {
  const FlexPage({super.key});

  @override
  State<FlexPage> createState() => _FlexPageState();
}

class _FlexPageState extends State<FlexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flex布局')),
      body: ListView(children: [
        Text('direction: Axis.horizontal 等于Row'),
        Flex(
          direction: Axis.horizontal,
          children: [_grid('格子1'), _grid('格子2'), _grid('格子3')],
        ),
        Divider(),
        Text('direction: Axis.vertical 等于Column'),
        Flex(
          direction: Axis.vertical,
          children: [_grid('格子1'), _grid('格子2'), _grid('格子3')],
        ),
      ]),
    );
  }

  Widget _grid(String title) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.all(2),
      color:
          Colors.accents[title.hashCode % Colors.accents.length].withAlpha(128),
      child: Center(child: Text(title)),
    );
  }
}
