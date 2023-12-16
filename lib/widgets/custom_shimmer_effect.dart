import 'package:bloc_text_feild/widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';

import 'my_tile_item.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: 20,
            itemBuilder: (context, index) {
              return const ListTileItem(title: '');
            }));
  }
}
