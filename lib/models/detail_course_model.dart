import 'package:arkademi/models/curriculum_model.dart';

class DetailCourseModel{
  String? courseName;
  String? progress;
  List<CurriculumModel>? curriculum;

  DetailCourseModel({
    this.courseName,
    this.progress,
    this.curriculum
  });

  factory DetailCourseModel.fromJson(Map<dynamic, dynamic> json){
    List<CurriculumModel> curriculumList = [];
    if(json['curriculum'] != null){
      var list = json['curriculum'] as List;
      curriculumList = list.map((i) => CurriculumModel.fromJson(i)).toList();
    }

    return DetailCourseModel(
      courseName: json['course_name'],
      progress: json['progress'],
      curriculum: curriculumList,
    );
  }

}