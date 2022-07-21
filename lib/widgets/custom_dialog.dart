import 'package:arkademi/widgets/space_divider.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final double? width;
  final double? height;
  final Color? dialogColor;
  final Color? titleColor;
  final String? title;
  final String? content;
  final String? actionTitle1;
  final String? actionTitle2;
  final bool? notSingleAction;
  final bool? action1IsFuture;
  final bool? action2IsFuture;
  final void Function()? action1;
  final void Function()? action2;
  final bool? enableClose;
  final int? type;

  const CustomDialog({
    Key? key,
    this.width,
    this.height,
    this.dialogColor,
    this.titleColor,
    this.title,
    this.content,
    this.actionTitle1,
    this.actionTitle2,
    this.notSingleAction,
    this.action1,
    this.action2,
    this.action1IsFuture,
    this.action2IsFuture,
    this.enableClose,
    required this.type,
  }) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
      return Future.value(false);
    },
    child: SizedBox(
      width: widget.width ?? double.infinity,
      child: Wrap(
          children: <Widget>[
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.type == 2 ? Colors.redAccent : Colors.blue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )
              ),
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.title ?? "",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  Visibility(
                    visible: widget.enableClose ??  true,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),

            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15.0),
                    child: Text(
                      widget.content ?? "",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87.withOpacity(0.7),),
                    ),
                  ),

                  SpaceDivider(
                    color: Colors.black87.withOpacity(0.1),
                    marginBot: 0,
                    marginTop: 12,
                  ),

                  SizedBox(
                    height: 45,
                    child: widget.notSingleAction == true ?
                    IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 50,
                              child: FlatButton(
                                onPressed: widget.action1 ?? (){Navigator.of(context).pop();},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      widget.actionTitle1 ?? "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87.withOpacity(0.7)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Container(
                            width: 1,
                            color: Colors.black87.withOpacity(0.1),
                          ),

                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 50,
                              child: FlatButton(
                                onPressed: widget.action2 ?? (){Navigator.of(context).pop();},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      widget.actionTitle2 ?? "",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        :
                    FlatButton(
                      onPressed: widget.action1 ?? (){Navigator.of(context).pop();},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.actionTitle1 ?? "",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: widget.type == 2 ? Colors.redAccent : Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    ),
    );
  }
}
