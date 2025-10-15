import 'package:flutter/material.dart';

import '../data_model/page_model.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.name,
    required this.pages,
  });

  final String name;
  final List<PageModel3> pages;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: ExpansionTile(
        shape: OutlineInputBorder(),
        initiallyExpanded: true,
        title: Text(name),
        textColor: primaryColor,
        collapsedTextColor: primaryColor,
        childrenPadding: EdgeInsets.only(left: 6),
        children: pages
            .map((page) => _buildItem(page.name, page.view, context))
            .toList(),
      ),
    );
  }

  Widget _buildItem(String title, Widget page, BuildContext context) {
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
