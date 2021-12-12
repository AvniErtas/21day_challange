//import 'package:animated_drawer/views/animated_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_21/screens/bottom_bar_view.dart';
import 'package:flutter_app_21/screens/design_course/models/tabIcon_data.dart';
import 'package:flutter_app_21/screens/profilepage.dart';
import 'package:flutter_app_21/screens/settingspage.dart';
import 'package:flutter_app_21/screens/welcomePage.dart';

import 'fitness_app_theme.dart';
import 'screens/design_course/home_design_course.dart';
import 'tools/sharedPreferencesHelper.dart';

/// Yan menüde profil,iletişim,gizlilik politikası kalsın
/// Eksik içerikleri tamamla (resim ve yazı)
/// Kendi meydan okuma sayfası içinde yeni kategori oluşturma

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: //WelcomePage(),
          Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  AnimationController? animationController;
  var coin;
  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = DesignCourseHomeScreen(animationController: animationController);
    coin = SharedPreferencesHelper.getInteger('coin');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* return AnimatedDrawer(
      homePageXValue: 150,
      homePageYValue: 80,
      homePageAngle: -0.2,
      homePageSpeed: 250,
      shadowXValue: 122,
      shadowYValue: 110,
      shadowAngle: -0.275,
      shadowSpeed: 550,
      openIcon: Icon(Icons.menu_open, color: Color(0xFF1f186f)),
      closeIcon: Icon(Icons.arrow_back_ios, color: Color(0xFF1f186f)),

      shadowColor: Color(0xFF4c41a3),
      backgroundGradient: LinearGradient(
        colors: [Color(0xFF4c41a3), Color(0xFF1f186f)],
      ),
      menuPageContent: Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 15),
        child: InkWell(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/design_course/profil_man.png",
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "BAY",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "AVEL",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.blue[200],
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 40),
                ),
                Row(
                  children: [
                    Icon(Icons.account_circle_rounded),
                    SizedBox(width: 3,),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfilePage()));
                      },
                      child: Text(
                        "Profilim",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Row(
                  children: [
                    Icon(Icons.share),
                    SizedBox(width: 3,),
                    Text(
                      "Paylaş",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                */ /*   Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
               Row(
                  children: [
                    Icon(Icons.attach_money),
                    SizedBox(width: 3,),
                    Text(
                      "Premium",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),*/ /*
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 3,),
                      Text(
                        "Ayarlar",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(
                  color: Color(0xFF5950a0),
                  thickness: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Row(
                  children: [
                    Icon(Icons.arrow_forward_ios_outlined),
                    SizedBox(width: 3,),
                    Text(
                      "İletişim",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Row(
                  children: [
                    Icon(Icons.announcement_outlined),
                    SizedBox(width: 3,),
                    Text(
                      "Gizlilik Politikası",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                */ /*Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Row(
                  children: [
                    Icon(Icons.assignment_turned_in_sharp),
                    SizedBox(width: 3,),
                    Text(
                      "Sıkça Sorulan Sorular",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),*/ /*

              ],
            ),
          ),
        ),
      ),
      homePageContent: Stack(children: [
        DesignCourseHomeScreen(),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.07,right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.attach_money,color: Colors.green,),
              Text(coin.toString())
            ],
          ),
        ),
        bottomBar(),
      ],
      ),
    );*/

    return Scaffold(
      body: Stack(children: [
        DesignCourseHomeScreen(),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.07, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.attach_money,
                color: Colors.green,
              ),
              Text(coin.toString())
            ],
          ),
        ),
        bottomBar(),
      ]),
    );
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0 || index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = DesignCourseHomeScreen(
                      animationController: animationController);
                });
              });
            } else if (index == 1 || index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = DesignCourseHomeScreen(
                      animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
