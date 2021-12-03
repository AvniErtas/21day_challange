import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var heightSpace = MediaQuery.of(context).size.height*0.05;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: heightSpace*2),
              Text('Tanıştığımıza memnun oldum.'),
              SizedBox(height: heightSpace),
              TextFormField(
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: Colors.white
                  ),
                  fillColor: Colors.white,
                  focusedBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  labelText: 'İsminiz nedir?',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                controller: _nameController,
                validator: (value) {
                  if (value!.length < 2) {
                    return 'Lütfen 2 karakterden uzun bir isim giriniz';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: heightSpace),
              Center(
                child: Container(
                  height: heightSpace,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff000000),
                        width: 1,
                      ),

                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Kadın'),
                      Text('Erkek'),
                      Text('Diğer'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: heightSpace),
              Text('Sevdiğim hayatı oluştur <3'),
              SizedBox(height: heightSpace*2),
              Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  onPressed: () => {},
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.navigate_next_outlined,color: Colors.amber,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
