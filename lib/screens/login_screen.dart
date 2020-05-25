import 'package:FiapEx/animations/login_animation.dart';
import 'package:FiapEx/components/form_container_fiap_ex.dart';
import 'package:FiapEx/components/sign_in_fiap_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  var animationStatus = 0;
  @override
  void initState() {
    super.initState();
    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }


  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return (
      Scaffold(
        resizeToAvoidBottomPadding: false,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: new ExactAssetImage('assets/login.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: <Color>[
                  const Color.fromRGBO(62, 76, 109, 0.3),
                  const Color.fromRGBO(51, 51, 63, 0.7),
                ],
                stops: [0.2, 1.0],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
              )),
              child: ListView(
                padding: const EdgeInsets.all(0.0),
                children: <Widget>[
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(height: 100,),
                          Image.asset('assets/images/fiaplogo.png',width: 200,),
                          SizedBox(height: 25,),
                          Image.asset('assets/images/exceptionlogo.png',width: 100,),
                          SizedBox(height: 70,),
                          

                          FormContainerFiapEx(),
                          Padding(padding: EdgeInsets.only(top:160.0,),)
                        ],
                      ),
                      animationStatus == 0
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      animationStatus = 1;
                                    });
                                    _playAnimation();
                                  },
                                  child: SignInFiapEx()),
                            )
                          : LoginAnimation(
                              buttonController:
                                  _loginButtonController.view),
                    ],
                  ),
                ],
              ))),
    ));
  }
}
