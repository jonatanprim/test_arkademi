import 'package:arkademi/controllers/course_controller.dart';
import 'package:arkademi/models/curriculum_model.dart';
import 'package:arkademi/utils/functions.dart';
import 'package:arkademi/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurriculumCard extends StatelessWidget {
  final CurriculumModel curriculum;
  final CourseController courseController = Get.put(CourseController());
  CurriculumCard({required this.curriculum, Key? key}) : super(key: key);

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
            : InkWell(
                onTap: () {
                  if(curriculum.onlineVideoLink == "" || curriculum.onlineVideoLink == null){
                    Get.dialog(
                        Dialog(
                          backgroundColor: Colors.transparent,
                          child: CustomDialog(
                              type: 2,
                              title: 'Gagal',
                              content: 'Link Video Sedang Bermasalah',
                              notSingleAction: false,
                              actionTitle1: "Ok",
                              action1: () {
                                Get.back();
                              }),
                        ),
                        barrierDismissible: false);
                  }
                  else{
                    courseController.selectedCurriculum.value = curriculum;
                    courseController.videoPlayerController.dispose();
                    courseController.chewieController!.dispose();
                    courseController.initializePlayer(curriculum, Functions().chekOfflineVideo(courseController.listVideo, curriculum.key));
                  }
                },
                child: Obx(
                  () => Container(
                    width: double.infinity,
                    color: courseController.selectedCurriculum.value.key == curriculum.key
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.white,
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
                        Obx(()=>
                        Functions().chekOfflineVideo(courseController.listVideo, curriculum.key) == false
                            ? Material(
                          child: InkWell(
                            onTap: () {
                              if(curriculum.onlineVideoLink == "" || curriculum.onlineVideoLink == null){
                                Get.dialog(
                                    Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: CustomDialog(
                                          type: 2,
                                          title: 'Gagal',
                                          content: 'Link Video Sedang Bermasalah',
                                          notSingleAction: false,
                                          actionTitle1: "Ok",
                                          action1: () {
                                            Get.back();
                                          }),
                                    ),
                                    barrierDismissible: false);
                              }
                              else{
                                courseController.downloadFile(curriculum.offlineVideoLink.toString(), curriculum.key.toString());
                              }
                            },
                            child: Container(
                              width: 110,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
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
                                        fontSize: 12,
                                        color: Colors.white),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                        )
                            : Row(
                          children: <Widget>[
                            Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 110,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0)),
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

                            const SizedBox(
                              width: 12,
                            ),

                            Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  courseController.deleteOfflineVideo(curriculum.key);
                                },
                                child: Container(
                                  width: 40,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0)),
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.grey.withOpacity(0.4)),
                                  ),
                                  child: Row(
                                    children: const <Widget>[
                                      Spacer(),
                                      Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
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
                      ],
                    ),
                  ),
                ),
              ),
        const Divider(
          height: 1,
          thickness: 1,
          color: Colors.black12,
        ),
      ],
    );
  }
}
