import 'dart:ui';

import 'package:flutter/material.dart';

class BasicInfoScreen extends StatelessWidget {
  const BasicInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (_, index) {
          return ListTile(
            title: Row(
              children: [
                Text(
                  'value',
                ),
                Text(
                  '$index',
                  style: TextStyle(
                    fontFeatures: [FontFeature.superscripts()],
                  ),
                ),
              ],
            ),
            leading: const Icon(
              Icons.info,
              color: Colors.blue,
            ),
          );
        });
  }
}
