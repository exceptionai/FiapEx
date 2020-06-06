import 'package:flutter/material.dart';

Widget callToAction({text = 'Get Started', homeRoute, context}) {
  return GestureDetector(
      onTap: () {
        try {
          Navigator.pushNamed(context, homeRoute);
        } catch (e) {
          print(e);
          print("Set homeRoute to the route where you want to land after on-boarding");
        }
      },
      child: Container(
    height: 70,
    width: double.infinity,
    color: Theme.of(context).primaryColor,
    child: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}
