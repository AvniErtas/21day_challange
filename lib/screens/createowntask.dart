import 'package:flutter/material.dart';

class CreateOwnTask extends StatefulWidget {
  const CreateOwnTask({Key? key}) : super(key: key);

  @override
  _CreateOwnTaskState createState() => _CreateOwnTaskState();
}

class _CreateOwnTaskState extends State<CreateOwnTask> {


  late String taskname;
  late String taskexp;

  List tasks = [];

  List<TextEditingController> _gunController =
      List.generate(21, (i) => TextEditingController());

  TextEditingController _tasknamecontroller = TextEditingController();
  TextEditingController _taskExpcontroller = TextEditingController();

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
        decoration: InputDecoration(
          labelText: 'Meydan Okuma Başlığı',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 2) {
            return 'Lütfen 2 karakterden uzun bir başlık giriniz';
          } else {
            return null;
          }
        },
        controller: _tasknamecontroller,
        //onChanged: (value) => setState(() => taskname = value),
      );

  Widget taskExplanation(index) => TextFormField(
        maxLines: 5,
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
        //onChanged: (value) => setState(() => taskexp = value),
     controller: _taskExpcontroller,
      );

  Widget taskslist(index) => Row(
        children: [
          Icon(Icons.calendar_today),
          Expanded(
            child: TextFormField(
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
              // onChanged: (value) => setState(() => tasks[index] = value),
            ),
          ),
        ],
      );

  void saveChallange() {

    var baslik = _tasknamecontroller.value.text;
    var aciklama = _taskExpcontroller.value.text;




  }
}
