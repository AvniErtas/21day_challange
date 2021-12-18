import 'package:flutter/material.dart';
import 'package:flutter_app_21/main.dart';
import 'package:flutter_app_21/screens/design_course/category_list_view.dart';
import 'package:flutter_app_21/screens/design_course/course_info_screen.dart';
import 'package:flutter_app_21/screens/design_course/popular_course_list_view.dart';
import '../profilepage.dart';
import 'design_course_app_theme.dart';

class DesignCourseHomeScreen extends StatefulWidget {

  const DesignCourseHomeScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  _DesignCourseHomeScreenState createState() => _DesignCourseHomeScreenState();
}

class _DesignCourseHomeScreenState extends State<DesignCourseHomeScreen> {


  CategoryType categoryType = CategoryType.first;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8,right: 8,bottom: 54),
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            getAppBarUI(),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                          child: Text(
                        "Bir mutluluk kapısı kapandığında diğeri açılır; ama çoğu zaman kapalı kapıya o kadar uzun süre bakarız ki bizim için açılan kapıyı görmeyiz.",
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      )),
                    ),
                    //getSearchBarUI(),
                    getCategoryUI(),
                    Flexible(
                      child: getPopularCourseUI(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
     Padding(
       padding: const EdgeInsets.only(left: 4, right: 4),
       child: Text(
            'Kaldığın yerden devam et',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
     ),
        CategoryListView(),

      ],
    );
  }

  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10,),
          Text(
            'Alışkanlıklar',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 19,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
          Flexible(
            child: PopularCourseListView(
            ),
          )
        ],
      ),
    );
  }


  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {

    //SelectedCategory ifadesini dinlememiz gerekiyor böylece kategori listesi tıkladığında güncellensin.
    int selectedCategory ;
    String categoryName ="";


    if (CategoryType.first == categoryTypeData) {
      selectedCategory = 1;
      categoryName ="Eğitim";
    } else if (CategoryType.second == categoryTypeData) {
      categoryName = 'Sağlık';
      selectedCategory = 2;
    } else if (CategoryType.third == categoryTypeData) {
      categoryName = 'Spor';
      selectedCategory = 3;
    } else if (CategoryType.last == categoryTypeData) {
      categoryName = 'Düzen';
      selectedCategory = 4;
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected
                ? DesignCourseAppTheme.nearlyBlue
                : DesignCourseAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: DesignCourseAppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 6, bottom: 6, left: 9, right: 9),
              child: Center(
                child: Text(
                  categoryName,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? DesignCourseAppTheme.nearlyWhite
                        : DesignCourseAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: DesignCourseAppTheme.nearlyBlue,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Search for course',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: HexColor('#B9BABC'),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: HexColor('#B9BABC'),
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search, color: HexColor('#B9BABC')),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            child: Container(
              width: 60,
              height: 60,
              child: Image.asset('assets/design_course/profil_man.png'),
            ),
          ),
          SizedBox(width: 5,),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text(
                DateTime.now().hour > 20 ? 'İyi Geceler' : 'İyi Günler',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: 0.2,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
              Text(
                'Mücadeleci',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.darkerText,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}

enum CategoryType {
  first,
  second,
  third,
  last,
}
