import 'package:flutter/material.dart';
import '../utils/constants/colors.dart';

class LayerOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 654,
      decoration: const BoxDecoration(
        color: layerOneBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.0),
          bottomRight: Radius.circular(60.0)
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 0,
              left: 80,
              child: Container(
                child: RichText(

                    text: const TextSpan(
                        text: 'By SLT IT Solutions Development ',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'v1.0', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                        ]
                    )),
              ))
        ],
      ),
    );
  }
}
