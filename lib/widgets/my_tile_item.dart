import 'package:flutter/material.dart';

class ListTileItem extends StatelessWidget {
  final String title;
  const ListTileItem({required this.title,super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
      ),
    );
  }
}
