import 'package:arkademi/controllers/course_controller.dart';
import 'package:arkademi/widgets/curriculum_card.dart';
import 'package:arkademi/widgets/persistent_header.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailCourse extends StatelessWidget {
  DetailCourse({Key? key}) : super(key: key);
  final CourseController courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: true,
              elevation: 1.0,
              pinned: true,
              floating: false,
              title: Obx(
                    () =>
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_back_outlined),
                          color: Colors.black87,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                              courseController.detailCourse.value.courseName
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        SizedBox(
                          width: 50,
                          child: CircularPercentIndicator(
                            radius: 18.0,
                            lineWidth: 3.0,
                            percent:
                            courseController.detailCourse.value.progress == null
                                ? 0
                                : double.parse(courseController
                                .detailCourse.value.progress
                                .toString()) /
                                100,
                            center: Text(
                              "${courseController.detailCourse.value.progress ??
                                  0}%",
                              style: const TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w700),
                            ),
                            progressColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.zero,
              sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Container(
                              height: 220,
                              color: Colors.green,
                              child: courseController.chewieController != null && courseController.chewieController!.videoPlayerController.value.isInitialized ?
                                  Chewie(
                                      controller: courseController.chewieController!) :
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      CircularProgressIndicator(),
                                      SizedBox(height: 10,),
                                      Text('Loading..'),
                                    ],
                                  ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0),
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            child: const Text(
                              'Persamaan Dasar Akuntansi',
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: PersistentHeader(
                widget: const TabBar(
                  unselectedLabelColor: Colors.black38,
                  labelColor: Colors.black87,
                  indicatorWeight: 4,
                  tabs: <Tab>[
                    Tab(
                      text: 'Kurikulum',
                    ),
                    Tab(text: 'Ikhtisar'),
                    Tab(text: 'Lampiran'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Obx(()=>
            ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: courseController.detailCourse.value.curriculum?.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return (CurriculumCard(
                      curriculum: courseController
                          .detailCourse.value.curriculum![index]));
                })
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 8,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Material(
                  child: InkWell(
                    onTap: () {},
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: Row(
                          children: const [
                            Spacer(),
                            Icon(
                              Icons.keyboard_double_arrow_left_outlined,
                              color: Colors.black87,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text('Sebelumnya',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700)),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const VerticalDivider(
                width: 1,
                thickness: 1,
                color: Colors.black12,
              ),
              Expanded(
                flex: 1,
                child: Material(
                  child: InkWell(
                    onTap: () {},
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: Row(
                          children: const [
                            Spacer(),
                            Text('Selanjutnya',
                                style: TextStyle(
                                    color: Colors.black26,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.keyboard_double_arrow_right_outlined,
                              color: Colors.black26,
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
