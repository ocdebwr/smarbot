import 'package:flutter/material.dart';

class GLButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const GLButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 140, 238, 194),
            borderRadius: BorderRadius.circular(40),
          ),
          padding: EdgeInsets.all(20),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),


            //ill make an icon also
            
          ])),
    );
  }
}
