import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text,text2;
  final String img;
  final VoidCallback voidCallback;

  const CustomDialogBox({Key? key, required this.title, required this.descriptions, required this.text,required this.text2, required this.img, required this.voidCallback}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  static const double padding =20;
  static const double avatarRadius =45;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: padding,top: avatarRadius
              + padding, right: padding,bottom: padding
          ),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Text(widget.descriptions,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: FlatButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text(widget.text,style: TextStyle(fontSize: 18),)),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                        onPressed: widget.voidCallback,
                        child: Text(widget.text2,style: TextStyle(fontSize: 18),)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: padding,
          right: padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(avatarRadius)),
                child: Image.asset(widget.img)
            ),
          ),
        ),
      ],
    );
  }
}