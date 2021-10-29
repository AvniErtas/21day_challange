import 'package:flutter/material.dart';
import 'package:flutter_app_21/database/database.dart';
import 'package:flutter_app_21/documents/challanges.dart';
import 'package:flutter_app_21/entity/UserProgress.dart';
import 'package:flutter_app_21/main.dart';
import 'package:flutter_app_21/screens/design_course/design_course_app_theme.dart';
import 'package:flutter_app_21/screens/design_course/models/category.dart';

import 'course_info_screen.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({Key? key}) : super(key: key);

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<List<UserProgress>> getProgressFromDB() async{
    var database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final userProgressDao = database.userProgressDao;
    final result = await userProgressDao.findAllUserProgress();
    return result;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.09,
      width: double.infinity,
      child: FutureBuilder<List<UserProgress>>(
        future: getProgressFromDB(),
        builder: (BuildContext context, AsyncSnapshot<List<UserProgress>> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(child: Center(child: Text('Henüz başladığınız bir alışkanlık bulunmamaktadır.')),);
          } else {
            if(snapshot.data!.isEmpty) {
              return const SizedBox(child: Center(child: Text('Henüz başladığınız bir alışkanlık bulunmamaktadır.')),);
            }
            return ListView.builder(
              padding: const EdgeInsets.only(
                  top: 0, bottom: 0, right: 8, left: 8),
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {

                final Animation<double> animation =
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: animationController!,
                            curve: Interval((1 / snapshot.data!.length) * index, 1.0,
                                curve: Curves.fastOutSlowIn)));
                animationController?.forward();

                return CategoryView(
                  index: index,
                  userProgress: snapshot.data![index],
                  animation: animation,
                  animationController: animationController,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key? key,
      required this.index,
      this.animationController,
      this.animation, this.userProgress})
      : super(key: key);

  final int index;
  final UserProgress? userProgress;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () => nextPage(context, index),
              child: SizedBox(
                width: 280,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                           SizedBox(
                            width: MediaQuery.of(context).size.width*0.1,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor('#17000000'),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 48 + 24.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Spacer(),
                                          Text(
                                            Challanges.challangeList[userProgress!.id].challangesName,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              letterSpacing: 0.27,
                                              color: DesignCourseAppTheme
                                                  .darkerText,
                                            ),
                                          ),
                                          /*const Expanded(
                                            child: SizedBox(),
                                          ),*/
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16, bottom: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '${userProgress!.lastDay} / ${Challanges.challangeList[userProgress!.id].days.length}',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 12,
                                                    letterSpacing: 0.27,
                                                    color: DesignCourseAppTheme
                                                        .grey,
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        '%${tamamlanmaYuzdesiHesapla(userProgress!.lastDay,Challanges.challangeList[userProgress!.id].days.length)}',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 18,
                                                          letterSpacing: 0.27,
                                                          color:
                                                              DesignCourseAppTheme
                                                                  .grey,
                                                        ),
                                                      ),
                                                     /* Icon(
                                                        Icons.,
                                                        color:
                                                            DesignCourseAppTheme
                                                                .nearlyBlue,
                                                        size: 20,
                                                      ),*/
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                             left: 16),
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(96.0)),
                              child: AspectRatio(
                                  aspectRatio: 0.8,
                                  child: Image.asset(Challanges.challangeList[userProgress!.id].imagePath)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  int tamamlanmaYuzdesiHesapla(int lastDay,int totalDay) {
    return lastDay*100~/totalDay;
  }

  nextPage(BuildContext context, int index) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CourseInfoScreen(index),
      ),
    );
  }
}
