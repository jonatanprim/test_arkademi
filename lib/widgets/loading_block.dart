import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingBlock extends StatelessWidget {
  final double? width;
  final double? height;
  final double? ml;
  final double? mr;
  final double? mt;
  final double? mb;
  const LoadingBlock({
    this.width,
    this.height,
    this.ml,
    this.mr,
    this.mt,
    this.mb,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[200]!,
        child: SizedBox(
          child: Container(
            margin: EdgeInsets.only(bottom: mb ?? 0, top: mt ?? 0, left:  ml ?? 0 , right: mr ?? 0),
            color: Colors.white,
            height: height ?? 10,
            width: width ?? 100,
          ),
        )
    );
  }
}