import 'package:flutter/material.dart';

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;

  PersistentHeader({required this.widget});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        elevation: 4.0,
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0))
        ),
        child: Center(child: widget),
      ),
    );
  }
  @override
  double get maxExtent => 50.0;
  @override
  double get minExtent => 50.0;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

