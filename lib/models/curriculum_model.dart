class CurriculumModel{
  int? key;
  String? id;
  String? type;
  String? title;
  int? duration;
  String? content;
  List<dynamic>? meta;
  int? status;
  String? onlineVideoLink;
  String? offlineVideoLink;

  CurriculumModel({
    this.key,
    this.id,
    this.type,
    this.title,
    this.duration,
    this.content,
    this.meta,
    this.status,
    this.onlineVideoLink,
    this.offlineVideoLink,
  });

  factory CurriculumModel.fromJson(Map<dynamic, dynamic> json){
    return CurriculumModel(
      key: json['key'],
      id: json['id'].toString(),
      type: json['type'],
      title: json['title'],
      duration: json['duration'],
      content: json['content'],
      meta: json['meta'],
      status: json['status'],
      onlineVideoLink: json['online_video_link'],
      offlineVideoLink: json['offline_video_link'],
    );
  }

}