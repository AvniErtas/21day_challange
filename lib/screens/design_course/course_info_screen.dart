import 'package:flutter/material.dart';
import 'package:flutter_app_21/database/database.dart';
import 'package:flutter_app_21/documents/challanges.dart';
import 'package:flutter_app_21/screens/taskDetails.dart';
import 'package:flutter_app_21/tools/expandableFab.dart';
import 'design_course_app_theme.dart';

class CourseInfoScreen extends StatefulWidget {
  int index;
  CourseInfoScreen(this.index);

  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen>
    with TickerProviderStateMixin {

  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 1.0;
  double opacity2 = 1.0;
  double opacity3 = 1.0;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
  }

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("1"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return FutureBuilder(
      future: getLastDayFromDb(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {  // AsyncSnapshot<Your object type>
        if( snapshot.connectionState == ConnectionState.waiting){
          return  CircularProgressIndicator();
        }else{
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {
            return Container(
              color: DesignCourseAppTheme.nearlyWhite,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: Image.asset(
                              Challanges.challangeList[widget.index].imagePath),
                        ),
                      ],
                    ),
                    Positioned(
                      top: (MediaQuery.of(context).size.width / 1.5) - 24.0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: DesignCourseAppTheme.nearlyWhite,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(32.0),
                              topRight: Radius.circular(32.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                                offset: const Offset(1.1, 1.1),
                                blurRadius: 10.0),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SingleChildScrollView(
                            child: Container(
                              constraints: BoxConstraints(
                                  minHeight: infoHeight,
                                  maxHeight: tempHeight > infoHeight
                                      ? tempHeight
                                      : infoHeight),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 32.0, left: 18, right: 16),
                                    child: Text(
                                        Challanges
                                            .challangeList[widget.index].challangesName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                        letterSpacing: 0.27,
                                        color: DesignCourseAppTheme.darkerText,
                                      ),
                                    ),
                                  ),
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16, top: 8, bottom: 8),
                                      child: Text(
                                        Challanges
                                            .challangeList[widget.index].description,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                          letterSpacing: 0.27,
                                          color: DesignCourseAppTheme.grey,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GridView(
                                      padding: const EdgeInsets.all(4),
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      children: List<Widget>.generate(
                                        21,
                                            (int index) {
                                          Animation<double> animation = createBoxAnimation(index);

                                          return getTimeBoxUI(
                                              index,
                                              snapshot.data!,
                                              animationController!,
                                              animation);
                                        },
                                      ),
                                      gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5, crossAxisSpacing: 2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                      child: SizedBox(
                        width: AppBar().preferredSize.height,
                        height: AppBar().preferredSize.height,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                            BorderRadius.circular(AppBar().preferredSize.height),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: DesignCourseAppTheme.nearlyBlack,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                floatingActionButton: ExpandableFab(
                  distance: 100.0,
                  children: [
                    FloatingActionButton.extended(
                      onPressed: () => _yenidenBaslat(),
                      icon: const Icon(Icons.refresh),
                      label: Text(
                        "Yeniden Başlat",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    FloatingActionButton.extended(
                      onPressed: () => _showAction(context, 1),
                      icon: const Icon(Icons.notification_important),
                      label: Text(
                        "Bildirimler",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    FloatingActionButton.extended(
                      onPressed: () => _showAction(context, 2),
                      icon: const Icon(Icons.hide_source),
                      label: Text(
                        "Gizle",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );

  }

  Animation<double> createBoxAnimation(int index) {
     final int count = 21;
    final Animation<double> animation =
        Tween<double>(begin: 0.0, end: 1.0)
            .animate(
      CurvedAnimation(
        parent: animationController!,
        curve: Interval((1 / count) * index, 1.0,
            curve: Curves.fastOutSlowIn),
      ),
    );
    animationController?.forward();
    return animation;
  }

  Widget getTimeBoxUI(int index,int lastDay,
      AnimationController? animationController, Animation<double> animation) {
    return InkWell(
      onTap: () {
        if((index+1) <= lastDay)
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TaskDetails(index+1,widget.index,lastDay)));
        else {
          final snackBar = SnackBar(content: Text('Bu günü açmak için diğerlerini tamamlamalısınız.'),backgroundColor: Colors.red,);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: AnimatedBuilder(
          animation: animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: animation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 50 * (1.0 - animation.value), 0.0),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: DesignCourseAppTheme.nearlyWhite,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: DesignCourseAppTheme.grey.withOpacity(0.2),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 8.0),
                      ],
                    ),
                    child: (index+1) <= lastDay ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          (index + 1).toString() + '.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.27,
                            color: DesignCourseAppTheme.nearlyBlue,
                          ),
                        ),
                        Text(
                          'Gün',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 14,
                            letterSpacing: 0.27,
                            color: DesignCourseAppTheme.grey,
                          ),
                        ),
                      ],
                    ) : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.lock_outline)
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<int> getLastDayFromDb() async {
    var database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final userProgressDao = database.userProgressDao;
    final result = userProgressDao.findUserProgressById(widget.index);
    var lastDay = 1;
    if(await result.first!=null)
    await result.first.then((value) => lastDay = value!.lastDay);
    return lastDay;
  }

  void _yenidenBaslat() async {
    var database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final userProgressDao = database.userProgressDao;
    final result = userProgressDao.findUserProgressById(widget.index);
    if (await result.first == null) {
      _showSnackbarFail();
    } else {
      result.first.then((value) => {
        value!.lastDay = 1,
        userProgressDao.updateUserProgress(value),
      });
      setState(() {
        _showSnackbarSuccess();
      });
    }
  }

  void _showSnackbarSuccess() {
    final snackBar = SnackBar(
      content: Text('Yeniden başlatıldı'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void _showSnackbarFail() {
    final snackBar = SnackBar(
      content: Text('Zaten başlamamışsınız!'),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
