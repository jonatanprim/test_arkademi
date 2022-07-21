import 'package:flutter/material.dart';

class SpaceDivider extends StatefulWidget {

  final Color? color;
  final double? marginTop;
  final double? marginBot;

  const SpaceDivider({
    this.color,
    Key? key,
    this.marginTop,
    this.marginBot,
  }) : super(key: key);

  @override
  _SpaceDividerState createState() => _SpaceDividerState();
}

class _SpaceDividerState extends State<SpaceDivider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: widget.marginTop ?? 10,
          ),

          Divider(
            height: 1,
            thickness: 1,
            color: widget.color ?? Colors.black26,
          ),

          SizedBox(
            height: widget.marginBot ?? 10,
          ),
        ],
      ),
    );
  }
}
