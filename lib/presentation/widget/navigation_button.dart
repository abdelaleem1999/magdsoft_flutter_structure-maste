import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  NavigationButton({
    this.Button_name,
    this.color
});
String? Button_name;
Color? color;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        width: MediaQuery.of(context).size.width/3,
        height: MediaQuery.of(context).size.height/14,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: color!
          //Color(0xFF005DA3),
        ),
        child:
        Center(
          child: Text(Button_name!,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold
            ),),
        ),

      ),
    );
  }
}
