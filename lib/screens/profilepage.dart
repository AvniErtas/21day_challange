import 'package:flutter/material.dart';
import 'package:animator/animator.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool cinsiyet;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
            child: Image.asset(
              "assets/design_course/profil_man.png",
              fit: BoxFit.cover,
            ),
            height: 100,
            width: 100,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.male,size: 30,),
              Text(
                "Avel",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.edit,
                color: Colors.deepOrangeAccent,
                size: 30,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.run_circle_outlined,size: 50,color: Colors.green,),
                  Text("23 Güncel\nMeydan Okuma",style: TextStyle(fontSize: 16,),),
                ],
              ),
              Column(
                children: [
                  Animator<double>(
                    tween: Tween<double>(begin: 0.8, end: 1.4),
                    curve: Curves.fastOutSlowIn,
                    cycles: 0,
                    builder: (_, animationState, __) => Transform.scale(
                      scale: animationState.value,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 50,
                      ),
                    ),
                  ),
                  // Text("\n0 Beğeni",style: TextStyle(fontSize: 16,),),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.check,size: 50,color: Colors.green,),
                  Text("Tamamlanan \nMeydan Okumalar",style: TextStyle(fontSize: 16,),),
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            child: Text(
              "Görevleri Göster",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              debugPrint("Butona tıklandı");
            },
          ),
        ],
      ),
    );
  }
}
