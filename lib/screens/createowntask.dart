import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_21/database/database.dart';
import 'package:flutter_app_21/entity/ownTask.dart';
import 'package:flutter_app_21/tools/custom_dialog_box.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class CreateOwnTask extends StatefulWidget {
  const CreateOwnTask({Key? key}) : super(key: key);

  @override
  _CreateOwnTaskState createState() => _CreateOwnTaskState();
}

class _CreateOwnTaskState extends State<CreateOwnTask> {
  late TutorialCoachMark tutorialCoachMark;
  final focus = FocusNode();
  List<TargetFocus> targets = <TargetFocus>[];

  List<TextEditingController> _gunController =
      List.generate(21, (i) => TextEditingController());

  TextEditingController _tasknamecontroller = TextEditingController();
  TextEditingController _taskExpcontroller = TextEditingController();

  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();

  @override
  void initState() {
    Future.delayed(Duration.zero, dialog);
    super.initState();
  }

  Future dialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Yardım menüsünü görmek istiyor musunuz?",
            descriptions:
                "",
            text: "Hayır",
            text2: "Evet",
            img: "assets/design_course/profil_man.png",
            voidCallback: () => {
              Future.delayed(Duration.zero, showTutorial),
              Navigator.of(context).pop(),
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveChallange();
        },
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text("Kendi Meydan Okumanı Oluştur"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              child: Column(
                children: [
                  buildTaskName(0),
                  SizedBox(
                    height: 5,
                  ),
                  taskExplanation(0),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              child: GridView.builder(
                  key: keyButton2,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 6,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: 21,
                  itemBuilder: (BuildContext ctx, index) {
                    return taskslist(index);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTaskName(index) => TextFormField(
    inputFormatters: [
      LengthLimitingTextInputFormatter(26),
    ],
        key: keyButton,
        decoration: InputDecoration(
          labelText: 'Meydan Okuma Başlığı',
          border: OutlineInputBorder(),
        ),
        controller: _tasknamecontroller,
        validator: (value) {
          if (value!.length < 2) {
            return 'Lütfen 2 karakterden uzun bir başlık giriniz';
          }
          else {
            return null;
          }
        },
      );

  Widget taskExplanation(index) => TextFormField(
        key: keyButton1,
        maxLines: 5,
        controller: _taskExpcontroller,
        decoration: InputDecoration(
          labelText: 'Açıklama',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 2) {
            return 'Lütfen 2 karakterden uzun bir başlık giriniz';
          } else {
            return null;
          }
        },
      );

  Widget taskslist(index) => Row(
        children: [
          Icon(Icons.calendar_today),
          Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.next,
              maxLines: 1,
              controller: _gunController[index],
              decoration: InputDecoration(
                labelText: "Gün ${index + 1}",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.length < 2) {
                  return 'Lütfen 2 karakterden uzun bir başlık giriniz';
                } else {
                  return null;
                }
              },
              onEditingComplete : () => FocusScope.of(context).nextFocus(),
              // onChanged: (value) => setState(() => tasks[index] = value),
            ),
          ),
        ],
      );

  void showTutorial() {
    initTargets();
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.orangeAccent,
      textSkip: "SKIP",
      textStyleSkip: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),
      paddingFocus: 10,
      opacityShadow: 0.9,
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onSkip: () {
        print("skip");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
    )..show();
  }

  void initTargets() {
    targets.clear();
    targets.add(TargetFocus(
        identify: "Target 1",
        keyTarget: keyButton,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
              align: ContentAlign.bottom,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Görev oluşturma zamanı",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Kendi oluşturacağın görevin başlığını buraya yazabilirsin.",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ))
        ]));

    targets.add(TargetFocus(
        identify: "Target 2",
        keyTarget: keyButton1,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
              align: ContentAlign.bottom,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Açıklama",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Görevin detaylarını tanımlayacak açıklamayı ise buraya yazmalısın.",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ))
        ]));
    targets.add(TargetFocus(
        identify: "Target 3",
        keyTarget: keyButton2,
        shape: ShapeLightFocus.RRect,
        paddingFocus: -15,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Günler",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Görevin için, 21 gün boyunca her gün yapman gerekenleri buraya doldurmalısın.Daha sonrasında artı butonuyla oluşturma işlemini tamamla!",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ))
        ]));
  }

  Future<void> saveChallange() async {
    List<String> gunler = [];
    var baslik = _tasknamecontroller.value.text;
    var aciklama = _taskExpcontroller.value.text;
    _gunController.forEach((element) {
      if(element.text.isEmpty) {
        _showSnackbarFail();
        return null;
      }

      gunler.add(element.text);
    });

    if(baslik.isEmpty || aciklama.isEmpty){
      _showSnackbarFail();
      return null;
    }

    OwnTask ownTask = OwnTask(null,baslik, aciklama,json.encode(gunler));

    var database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final ownTaskDao = database.ownTaskDao;
    await ownTaskDao.insertOwnTask(ownTask);

    _showSnackbarSuccess();

    _tasknamecontroller.clear();
    _taskExpcontroller.clear();
    _gunController.forEach((element) {
      element.clear();
    });
  }

  void _showSnackbarSuccess() {
    final snackBar = SnackBar(
      content: Text('Başarıyla kaydedildi'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showSnackbarFail() {
    final snackBar = SnackBar(
      content: Text('Tüm alanları doldurunuz!'),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

