import 'package:arkademi/models/curriculum_model.dart';
import 'package:arkademi/models/detail_course_model.dart';
import 'package:arkademi/services/course_service.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class CourseController extends GetxController{
  var isLoading = false.obs;
  var detailCourse = DetailCourseModel().obs;
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  var selectedCurriculum = CurriculumModel().obs;

  @override
  void onInit() {
    getDetailCourse();
    initializePlayer(selectedCurriculum.value);
    super.onInit();
  }

  Future<void> initializePlayer(CurriculumModel curriculum)async {
    print("LINK : ${curriculum.onlineVideoLink}");
    videoPlayerController = VideoPlayerController.network("https://storage.googleapis.com/samplevid-bucket/offline_arsenal_westham.mp4");

    await Future.wait([videoPlayerController.initialize()]);
    chewieController=ChewieController(
      videoPlayerController: videoPlayerController, autoPlay: true, looping: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.redAccent,
        handleColor: Colors.red,
        backgroundColor: Colors.black12,
        bufferedColor: Colors.grey,
      ),
      placeholder: Container(
        color: Colors.black54,
      ),
      autoInitialize: true,
    );

    update();
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.onClose();
  }

  // Function to get prepare list
  Future getDetailCourse() async {
    isLoading(true);
    final courseData = await CourseService().getDetailCourse();
    if(courseData != null){
      detailCourse.value = DetailCourseModel();
      detailCourse.value = DetailCourseModel.fromJson(courseData);
      selectedCurriculum.value = CurriculumModel.fromJson(courseData['curriculum'][0]);
      initializePlayer(selectedCurriculum.value);
      isLoading(false);
    }
    else{
      isLoading(false);
    }
  }


}