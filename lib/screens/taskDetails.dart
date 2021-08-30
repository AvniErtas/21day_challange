import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_21/database/database.dart';
import 'package:flutter_app_21/documents/challanges.dart';
import 'package:flutter_app_21/entity/UserProgress.dart';
import 'package:flutter_app_21/tools/sharedPreferencesHelper.dart';
import 'package:scratcher/scratcher.dart';
import 'package:flutter_app_21/dao/UserProgressDao.dart';

class TaskDetails extends StatefulWidget {
  final dayIndex;
  final challangeIndex;

  const TaskDetails(this.dayIndex, this.challangeIndex, {Key? key})
      : super(key: key);

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  String note = "";
  var isFinish = true;
  var isFinishAd = true;
  final scratchKey = GlobalKey<ScratcherState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Icon(Icons.edit),
              onTap: () {
                showAlertDialog(context);

                /// TODO DİYALOĞU HAZIRLA
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.attach_money,
                color: Colors.yellow,
              )),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
                child: Text(
                  SharedPreferencesHelper.getInteger('coin').toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
          ),
        ],
        title: Text("Gün ${widget.dayIndex + 1}"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bugünün Meydan Okumasını Görmek İçin Kazı",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Scratcher(
                    key: scratchKey,
                    brushSize: 30,
                    threshold: 0,
                    rebuildOnResize: true,
                    color: Colors.red,
                    onChange: (value) => print("Scratch progress: $value%"),
                    onThreshold: () => print("Threshold reached, you won!"),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(45),
                        ),
                      ),
                      height: 250,
                      width: 250,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            Challanges.challangeList[widget.challangeIndex]
                                .days[widget.dayIndex],
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        child: Row(
                          children: [
                            Text(
                              "Paylaş",
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        onPressed: () {
                          paylas();
                        },
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        child: Text(
                          "Kazımayı Atla",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            scratchKey.currentState!.isFinished = true;
                          });
                        },
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: isFinish,
                  child: RaisedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: Colors.yellow,
                        ),
                        Text(
                          "Meydan Okuma Tamamlandı | 2 Puan",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () {
                      scratchKey.currentState!.isFinished = true;
                      setState(() {
                        isFinish = false;
                      });
                      _meydanOkumaTamamlandi();
                    },
                    color: Colors.deepOrangeAccent,
                  ),
                ),
                Visibility(
                  visible: isFinishAd,
                  child: RaisedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.album_outlined,
                          color: Colors.yellow,
                        ),
                        Text(
                          "Meydan Okuma Tamamlandı | 5 Puan",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () {
                      scratchKey.currentState!.isFinished = true;
                      setState(() {
                        isFinish = false;
                        isFinishAd = false;
                      });
                      _meydanOkumaTamamlandiAd();
                    },
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveToDb(int coin) async{
    var database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final userProgressDao = database.userProgressDao;
    final result =
    userProgressDao.findUserProgressById(widget.challangeIndex);
    if (await result.first == null) {
      final progress =
      UserProgress(widget.challangeIndex, widget.dayIndex + 1);
      await userProgressDao.insertUserProgress(progress);

      _coinSave(coin);
    }else {
      result.first.then((value) => {
        if(value!.lastDay<(widget.dayIndex+1)) {
          value.lastDay = value.lastDay + 1,

          userProgressDao.updateUserProgress(value),

          _coinSave(coin),
          _showSnackbarSuccess()
        } else {
          _showSnackbarFail()
        }
      });
    }
  }

  void _showSnackbarSuccess() {
    final snackBar = SnackBar(content: Text('Meydan okuma tamamlandı'),backgroundColor: Colors.green,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void _showSnackbarFail() {
    final snackBar = SnackBar(content: Text('Daha önceden tamamladınız!'),backgroundColor: Colors.red,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _meydanOkumaTamamlandi() async {
    _saveToDb(coinValue);
  }

  void _meydanOkumaTamamlandiAd() async {
    _saveToDb(coinAdValue);
  }

  void _coinSave(int value) async {
    int coin = SharedPreferencesHelper.getInteger('coin');
    SharedPreferencesHelper.putInteger('coin', coin+value);

    coin = SharedPreferencesHelper.getInteger('coin');
    print('coin: $coin');
  }

  void paylas() async{
  /*  var database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final userProgressDao = database.userProgressDao;
    userProgressDao.findUserProgressById(0).first.then((value) => debugPrint('son gün= ${value!.lastDay.toString()}'));*/



  }

  showAlertDialog(BuildContext context) {
    TextEditingController textEditingController = new TextEditingController();

    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Kaydet"),
      onPressed: () {
        Navigator.pop(context);
        var note = textEditingController.text;

        debugPrint("$note");
      },
    );
    Widget launchButton = ElevatedButton(
      child: Text("Vazgeç"),
      onPressed: () {
        setState(() {
          note = "";
        });
        Navigator.pop(context);
        debugPrint("$note");
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Container(
        child: Image.asset("assets/design_course/interFace3.png"),
        height: 80,
      ),
      actions: [
        TextFormField(
          controller: textEditingController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Notunuzu Yazın',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.length < 2) {
              return 'Lütfen 2 karakterden uzun bir başlık giriniz';
            } else {
              return null;
            }
          },
          // onChanged: (value) => note = value),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            cancelButton,
            launchButton,
          ],
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
