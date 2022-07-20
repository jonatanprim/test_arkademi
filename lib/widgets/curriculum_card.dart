import 'package:arkademi/models/curriculum_model.dart';
import 'package:arkademi/utils/functions.dart';
import 'package:flutter/material.dart';

class CurriculumCard extends StatelessWidget {
  final CurriculumModel curriculum;
  const CurriculumCard({required this.curriculum, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        curriculum.type == 'section'
            ? Container(
                width: double.infinity,
                color: Colors.grey.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      curriculum.title.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${Functions().getDuration(curriculum.duration)} Menit",
                      style: const TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Functions().checkLink(curriculum.onlineVideoLink,
                                  curriculum.offlineVideoLink) ==
                              false
                          ? Icons.info
                          : Icons.play_circle,
                      color: Colors.grey,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            curriculum.title.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87.withOpacity(0.7)),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "${Functions().getDuration(curriculum.duration)} Menit",
                            style: const TextStyle(
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                    curriculum.offlineVideoLink != null ||
                            curriculum.offlineVideoLink != ""
                        ? Material(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: 110,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.grey.withOpacity(0.4)),
                                ),
                                child: Row(
                                  children: const <Widget>[
                                    Spacer(),
                                    Text(
                                      "Tonton Offline",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: 110,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.grey.withOpacity(0.4)),
                                ),
                                child: Row(
                                  children: const <Widget>[
                                    Spacer(),
                                    Text(
                                      "Tersimpan",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: Colors.blue,
                                      size: 16,
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.black12,
        ),
      ],
    );
  }
}
