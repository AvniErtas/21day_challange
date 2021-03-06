import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_21/database/database.dart';
import 'package:flutter_app_21/documents/challanges.dart';
import 'package:flutter_app_21/entity/UserProgress.dart';
import 'package:flutter_app_21/entity/challangeNote.dart';
import 'package:flutter_app_21/tools/sharedPreferencesHelper.dart';
import 'package:scratcher/scratcher.dart';
import 'package:flutter_app_21/dao/UserProgressDao.dart';

class TaskDetails extends StatefulWidget {
  final dayIndex;
  final challangeIndex;
  final lastDay;

  const TaskDetails(
    this.dayIndex,
    this.challangeIndex,
    this.lastDay, {
    Key? key,
  }) : super(key: key);

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  void initState() {
    if (widget.dayIndex < widget.lastDay) {
      isFinish = false;
      isFinishAd = false;
    }
    coin = SharedPreferencesHelper.getInteger('coin');
    super.initState();
  }
  var coin;
  var isFinish = true;
  var isFinishAd = true;
  var time = DateTime.now();
  var time2 = DateTime.utc(2021,12,12);
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
              coin.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
          ),
        ],
        title: Text("Gün ${widget.dayIndex}"),
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
                                .days[widget.dayIndex-1],
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
                        coin+=2;
                      });
                      _meydanOkumaTamamlandi();
                    },
                    color: Colors.deepOrangeAccent,
                  ),
                ),
               /* Visibility(
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
                        coin+=5;
                      });
                      _meydanOkumaTamamlandiAd();
                    },
                    color: Colors.deepOrangeAccent,
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  void _saveToDb(int coin) async {
    var database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final userProgressDao = database.userProgressDao;
    final result = userProgressDao.findUserProgressById(widget.challangeIndex);
    if (await result.first == null) {
      final progress = UserProgress(widget.challangeIndex, widget.dayIndex + 1,DateTime.now().toString());
      await userProgressDao.insertUserProgress(progress);

      _coinSave(coin);
    } else {
      result.first.then((value) => {
            if (value!.lastDay < (widget.dayIndex + 1))
              {
                value.lastDay = value.lastDay + 1,
                userProgressDao.updateUserProgress(value),
                _coinSave(coin),
                _showSnackbarSuccess()
              }
            else
              {_showSnackbarFail()}
          });
    }
  }

  void _showSnackbarSuccess() {
    final snackBar = SnackBar(
      content: Text('Meydan okuma tamamlandı'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showSnackbarFail() {
    final snackBar = SnackBar(
      content: Text('Daha önceden tamamladınız!'),
      backgroundColor: Colors.red,
    );
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
    SharedPreferencesHelper.putInteger('coin', coin + value);

    coin = SharedPreferencesHelper.getInteger('coin');
    print('coin: $coin');
  }

  void paylas() async {
    /*  var database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final userProgressDao = database.userProgressDao;
    userProgressDao.findUserProgressById(0).first.then((value) => debugPrint('son gün= ${value!.lastDay.toString()}'));*/
  }

  showAlertDialog(BuildContext context) async{
    TextEditingController textEditingController = new TextEditingController();
    var note = await noteGoruntule();
    if(note!=null)
    textEditingController.text = note;
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Vazgeç"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget launchButton = ElevatedButton(
      child: Text("Kaydet"),
      onPressed: () {
        Navigator.pop(context);
        var getNote = textEditingController.text;
        noteKaydet(getNote);
        debugPrint("$getNote");
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

  Future<String?> noteGoruntule() async {
    var database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    var challange = await database.challangeNoteDao.findChallangeNoteByIdAndDayId(widget.challangeIndex,widget.dayIndex);
    return challange?.note;
  }

  void noteKaydet(String note) async {
    var database =
    await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    var lastChallange = await database.challangeNoteDao.findChallangeNoteByIdAndDayId(widget.challangeIndex,widget.dayIndex);

    var snackBar = SnackBar(
      content: Text('Başarıyla kaydedildi.'), backgroundColor: Colors.green,);

    if(lastChallange==null) {
      var challangeNote = ChallangeNote(
          widget.challangeIndex, widget.dayIndex, note);
      await database.challangeNoteDao.insertChallangeNote(challangeNote);
    }else {
      lastChallange.note = note;
      database.challangeNoteDao.updateChallangeNote(lastChallange);
      snackBar = SnackBar(
        content: Text('Başarıyla güncellendi.'), backgroundColor: Colors.green,);
    }


    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
