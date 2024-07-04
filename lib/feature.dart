import 'package:flutter/material.dart';

class FFeature extends StatelessWidget {
  final String address;
  final String text;
  final Color ccolor;
  final Widget page; // Add page parameter for navigation

  const FFeature({
    Key? key,
    required this.address,
    required this.text,
    required this.ccolor,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 100,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page), // Navigate to the specified page
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: ccolor,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      address,
                      scale: 24,
                      color: ccolor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
