import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:arkademi/models/curriculum_model.dart';
import 'package:arkademi/models/detail_course_model.dart';
import 'package:arkademi/services/course_service.dart';
import 'package:arkademi/utils/functions.dart';
import 'package:arkademi/widgets/custom_dialog.dart';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class CourseController extends GetxController{
  // loading for get data from API
  var isLoading = false.obs;
  // loading for initialize video
  var isLoadingVideo = false.obs;
  // loading for download video
  var isDownloading = false.obs;
  // download progress
  var progress = "0%".obs;
  // detail course
  var detailCourse = DetailCourseModel().obs;
  // video player controller
  late VideoPlayerController videoPlayerController;
  // chewie controller
  ChewieController? chewieController;
  // selected item curriculum
  var selectedCurriculum = CurriculumModel().obs;
  // list of offline video key
  var listVideo = [].obs;
  // path of saved video
  var path = "".obs;

  @override
  void onInit() {
    // When controller initialize run function getDetail Course
    getDetailCourse();
    super.onInit();
  }

  // Initialize player, check whether the video is available in offline mode or not
  Future<void> initializePlayer(CurriculumModel curriculum, bool isOffline)async {
    isLoadingVideo(true);
    if(isOffline == true){
      videoPlayerController = VideoPlayerController.file(File("${path.value}/${curriculum.key}.mp4"));
    }
    else{
      videoPlayerController = VideoPlayerController.network(curriculum.onlineVideoLink.toString());
    }
    await Future.wait([videoPlayerController.initialize()]);
    // set chewie controller settings
    chewieController=ChewieController(
      videoPlayerController: videoPlayerController, autoPlay: false, looping: false,
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
    isLoadingVideo(false);
  }

  // when the controller is closed
  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.onClose();
  }

  // Function to get detail course
  Future getDetailCourse() async {
    isLoading(true);
    final courseData = await CourseService().getDetailCourse();
    if(courseData != null){
      detailCourse.value = DetailCourseModel();
      detailCourse.value = DetailCourseModel.fromJson(courseData);
      // Set the initial value of the selected Curriculum, the first item whose online video link is not empty
      for(int i = 0; i<detailCourse.value.curriculum!.length; i++){
        if(detailCourse.value.curriculum![i].onlineVideoLink != null && detailCourse.value.curriculum![i].onlineVideoLink != ""){
          selectedCurriculum.value = CurriculumModel.fromJson(courseData['curriculum'][i]);
          break;
        }
      }
      // retrieves the list of downloaded video keys, if it doesn't exist it will return an empty list value
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = jsonDecode(prefs.getString("listVideo") == null ? jsonEncode({'listVideo':[]}) : prefs.getString("listVideo")!);
      listVideo.value = data['listVideo'];
      // retrieve saved video path
      var dir = await getApplicationDocumentsDirectory();
      path.value = dir.path;
      // run function initializePlayer
      initializePlayer(selectedCurriculum.value, Functions().chekOfflineVideo(listVideo, selectedCurriculum.value.key));
      isLoading(false);
    }
    else{
      isLoading(false);
    }
  }

  // Download video
  Future<void> downloadFile(linkVideo, key) async {
    // Get list downloaded video key from shared preference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = jsonDecode(prefs.getString("listVideo") == null ? jsonEncode({'listVideo':[]}) : prefs.getString("listVideo")!);
    // Initialize dio
    Dio dio = Dio();
    try {
      // Path directory
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(linkVideo, "${dir.path}/$key.mp4",
          onReceiveProgress: (rec, total) {
              // when download in progress change progress value
              isDownloading.value = true;
              progress.value = "${((rec / total) * 100).toStringAsFixed(0)}%";
            });
      // Update listVideo value & update shared preference value
      data['listVideo'].add(key);
      listVideo.value = data['listVideo'];
      prefs.setString("listVideo", jsonEncode(data));
      isDownloading.value = false;
    } catch (e) {
      isDownloading.value = false;
      log(e.toString());
    }
  }

  // Delete Offline video
  Future<void> deleteOfflineVideo(key) async {
    // Get list downloaded video key from shared preference
    var flag = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = jsonDecode(prefs.getString("listVideo") == null ? jsonEncode({'listVideo':[]}) : prefs.getString("listVideo")!);
    // remove key from list key
    for(int i = 0 ; i < data['listVideo'].length ; i++){
      if(data['listVideo'][i] == key.toString()){
        data['listVideo'].removeAt(i);
      }
      else{
      }
      listVideo.value = data['listVideo'];
      prefs.setString("listVideo", jsonEncode(data));
      // remove file from path
      try {
        final file = File("${path.value}/$key.mp4");
        await file.delete();
        flag = true;
      } catch (e) {
        flag = false;
      }
      // show dialog according result
      if(flag == true){
        Get.dialog(
            Dialog(
              backgroundColor: Colors.transparent,
              child: CustomDialog(
                  type: 1,
                  title: 'Berhasil',
                  content: 'Video berhasil dihapus',
                  notSingleAction: false,
                  actionTitle1: "Ok",
                  action1: () {
                    Get.back();
                  }),
            ),
            barrierDismissible: false);
      }
      else{
        Get.dialog(
            Dialog(
              backgroundColor: Colors.transparent,
              child: CustomDialog(
                  type: 2,
                  title: 'Gagal',
                  content: 'gagal Menghapus Video',
                  notSingleAction: false,
                  actionTitle1: "Ok",
                  action1: () {
                    Get.back();
                  }),
            ),
            barrierDismissible: false);
      }
    }
  }

}