import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_21/documents/challanges.dart';
import 'package:scratcher/scratcher.dart';

class TaskDetails extends StatefulWidget {
  final dayIndex;
  final challangeIndex;

  const TaskDetails(this.dayIndex,this.challangeIndex,{ Key? key}) : super(key: key);

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {

  String note = "";

  @override
  Widget build(BuildContext context) {
    final scratchKey = GlobalKey<ScratcherState>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(child: Icon(Icons.edit),onTap: (){
              showAlertDialog(context);
              /// TODO DİYALOĞU HAZIRLA
            },),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.attach_money,color: Colors.yellow,)
          ),
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Center(child: Text("90",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
          ),
        ],
        title: Text("Gün ${widget.dayIndex+1}"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bugünün Meydan Okumasını Görmek İçin Kazı",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Center(
              child: Scratcher(
                key: scratchKey,
                brushSize: 30,
                threshold: 0,
                //rebuildOnResize: true,
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
                      child: Text(Challanges.challangeList[widget.challangeIndex].days[widget.dayIndex],style: TextStyle(fontSize: 16,),textAlign: TextAlign.center,),
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
                        Icon(Icons.share,color: Colors.white,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onPressed: () {
                      debugPrint("Butona tıklandı");
                    },
                  color: Colors.deepOrangeAccent,),

                ),
                SizedBox(width: 10,),
                Expanded(
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    child: Text(
                      "Kazımayı Atla",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      scratchKey.currentState!.isFinished = true;
                    },
                  color: Colors.deepOrangeAccent,),
                ),

              ],
            ),
            RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.attach_money,color: Colors.yellow,),
                  Text(
                    "Meydan Okuma Tamamlandı | 2 Puan",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onPressed: () {
                scratchKey.currentState!.isFinished = true;
              },
              color: Colors.deepOrangeAccent,),
            RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.album_outlined,color: Colors.yellow,),
                  Text(
                    "Meydan Okuma Tamamlandı | 5 Puan",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onPressed: () {
                scratchKey.currentState!.isFinished = true;
              },
              color: Colors.deepOrangeAccent,),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {


    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Kaydet"),
      onPressed:  () {
        Navigator.pop(context);
        debugPrint("$note");
      },

    );
    Widget launchButton = ElevatedButton(
      child: Text("Vazgeç"),
      onPressed:  () {
        setState(() {
          note = "";
        });
        Navigator.pop(context);
        debugPrint("$note");
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Container(child: Image.asset("assets/design_course/interFace3.png"),height: 80,),
      actions: [
        TextFormField(
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
          onChanged: (value) => setState(() => note = value),
        ),
        SizedBox(height: 5,),
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
