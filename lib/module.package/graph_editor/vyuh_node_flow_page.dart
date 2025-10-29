// import 'package:flutter/material.dart';
// import 'package:vyuh_node_flow/graph/node_flow_controller.dart';
// import 'package:vyuh_node_flow/graph/node_flow_editor.dart';
// import 'package:vyuh_node_flow/graph/node_flow_theme.dart';
// import 'package:vyuh_node_flow/nodes/node.dart';
// import 'package:vyuh_node_flow/ports/port.dart';

// class VyuhNodeFlowPage extends StatefulWidget {
//   const VyuhNodeFlowPage({super.key});

//   @override
//   State<VyuhNodeFlowPage> createState() => _VyuhNodeFlowPageState();
// }

// class _VyuhNodeFlowPageState extends State<VyuhNodeFlowPage> {
//   late final NodeFlowController<String> controller;

//   @override
//   void initState() {
//     super.initState();

//     // 1. Create the controller
//     controller = NodeFlowController<String>();

//     // 2. Add some nodes
//     controller.addNode(Node<String>(
//       id: 'node-1',
//       type: 'input',
//       position: const Offset(100, 100),
//       data: 'Input Node',
//       outputPorts: const [Port(id: 'out', name: 'Output')],
//     ));

//     controller.addNode(Node<String>(
//       id: 'node-2',
//       type: 'output',
//       position: const Offset(400, 100),
//       data: 'Output Node',
//       inputPorts: const [Port(id: 'in', name: 'Input')],
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('vyuh_node_flow')),
//       body: NodeFlowEditor<String>(
//         controller: controller,
//         theme: Theme.brightnessOf(context) == Brightness.dark
//             ? NodeFlowTheme.dark
//             : NodeFlowTheme.light,
//         nodeBuilder: (context, node) => _buildNode(node),
//       ),
//     );
//   }

//   Widget _buildNode(Node<String> node) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Text(node.data),
//     );
//   }
// }
