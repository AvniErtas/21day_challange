import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_21/documents/challanges.dart';
import 'package:flutter_app_21/entity/ownTask.dart';
import 'package:flutter_app_21/model/Challange.dart';
import 'dart:convert';
import '../../main.dart';
import 'course_info_screen.dart';
import 'design_course_app_theme.dart';
import 'models/category.dart';
import 'package:flutter_app_21/database/database.dart';

class PopularCourseListView extends StatefulWidget {
  const PopularCourseListView({Key? key}) : super(key: key);

  @override
  _PopularCourseListViewState createState() => _PopularCourseListViewState();
}

class _PopularCourseListViewState extends State<PopularCourseListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  late Future<List<Challange>> _getData;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _getData = getData();
    super.initState();
  }

  Future<List<Challange>> getData() async {
    var database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final ownTaskDao = database.ownTaskDao;
    var taskList = await ownTaskDao.findAllOwnTask();
    // OwnTask olusturulanTask = OwnTask(1, "baslik", "aciklama", "gunler");
    var challangeList = Challanges.challangeList;
    taskList.forEach((element) {
      List<String> gunler = List<String>.from(json.decode(element.gunler));
      var newChallange =  Challange(challangesName: element.baslik,description: element.aciklama,imagePath: "assets/design_course/verimlilik.jpg",days: gunler);
      challangeList.add(newChallange);
    });
    print(challangeList.length.toString());
    return challangeList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<List<Challange>>(
        future: _getData,
        builder: (BuildContext context, AsyncSnapshot<List<Challange>> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return GridView(
              padding: const EdgeInsets.all(4),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
                snapshot.data!.length,
                (int index) {
                  final int count = snapshot.data!.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController!,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController?.forward();
                  return CategoryView(
                    index: index,
                    challange: snapshot.data![index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14.0,
                crossAxisSpacing: 24.0,
                childAspectRatio: 1.6,
              ),
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
      required this.challange,
      this.animationController,
      this.animation})
      : super(key: key);
  final int index;
  final Challange challange;
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
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () => nextPage(context, index),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: HexColor('#F8FAFB'),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              // border: new Border.all(
                              //     color: DesignCourseAppTheme.notWhite),
                            ),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        AutoSizeText(
                                          challange.challangesName,
                                          textAlign: TextAlign.left,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            letterSpacing: 0.27,
                                            color:
                                                DesignCourseAppTheme.darkerText,
                                          ),
                                        ),
                                        /*Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              left: 16,
                                              right: 16,
                                              bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                '${challange..lessonCount} lesson',
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
                                                      '${category!.rating}',
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
                                                    Icon(
                                                      Icons.star,
                                                      color:
                                                          DesignCourseAppTheme
                                                              .nearlyBlue,
                                                      size: 20,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),*/
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 48,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 24, right: 16, left: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color:
                                    DesignCourseAppTheme.grey.withOpacity(0.2),
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 6.0),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                          child: AspectRatio(
                              aspectRatio: 1.28,
                              child: Image.asset(challange.imagePath)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  nextPage(BuildContext context, int index) {
    /* Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CourseInfoScreen(index),
      ),
    );*/
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return CourseInfoScreen(index);
    }));
  }
}
