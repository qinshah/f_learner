// import 'package:flutter/material.dart';
// import 'package:universal_platform/universal_platform.dart';

// class PluginInfoTable extends StatelessWidget {
//   final String name;
//   final String url;
//   final List<UniversalPlatformType> platforms;

//   const PluginInfoTable({
//     super.key,
//     required this.name,
//     required this.url,
//     required this.platforms,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Table(
//       border: TableBorder.all(),
//       columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
//       children: [
//         TableRow(
//           children: [
//             TableCell(
//                 child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: const Text('插件名'),
//             )),
//             TableCell(
//                 child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Text(name),
//             )),
//           ],
//         ),
//         TableRow(
//           children: [
//             TableCell(
//                 child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: const Text('链接'),
//             )),
//             TableCell(
//                 child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Text(url),
//             )),
//           ],
//         ),
//         TableRow(
//           children: [
//             TableCell(
//                 child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: const Text('支持平台'),
//             )),
//             TableCell(
//                 child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Text(platforms.map((p) => p.name).join(',')),
//             )),
//           ],
//         ),
//       ],
//     );
//   }
// }
