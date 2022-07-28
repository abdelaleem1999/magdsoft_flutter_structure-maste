import 'package:flutter/material.dart';

class Translation_Button extends StatelessWidget {
  Translation_Button({
    this.Button_name
});
  String? Button_name;

@override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 50,right: 15),
      child: Container(
        width: MediaQuery.of(context).size.width/4.2,
        height: MediaQuery.of(context).size.height/18,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
          //Color(0xFF005DA3),
        ),
        child:
        Center(
          child: Text(Button_name!,
            style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
                fontWeight: FontWeight.bold
            ),),
        ),

      ),
    );
  }
}
