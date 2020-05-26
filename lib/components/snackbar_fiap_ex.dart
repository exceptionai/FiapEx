import 'package:flutter/material.dart';

class SnackbarFiapEx {

  GlobalKey<ScaffoldState> scaffoldKey;

  SnackbarFiapEx({this.scaffoldKey});

  show(String text) {
    scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        content: Text(
          text,
        ),
      ),
    );
  }
}