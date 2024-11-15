import 'package:flutter/material.dart';
import '../utils/constants/colors.dart';

class LayerTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 399,
      height: 544,
      decoration: const BoxDecoration(
        color: layerTwoBg,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60.0),
            bottomRight: Radius.circular(60.0),
            bottomLeft: Radius.circular(60.0),
        ),
      ),

    );
  }
}
