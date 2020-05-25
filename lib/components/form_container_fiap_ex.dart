import 'package:flutter/material.dart';

class FormContainerFiapEx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
           Form(
              child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextFormField(
                style: TextStyle(
                    fontFamily: 'GothamHTF',
                  
                  color: Colors.white
                ),
                initialValue: 'flaviomoreni',
                decoration: InputDecoration(
                  icon: Icon(Icons.person,color: Colors.white,),
                  focusColor: Colors.white,
                  hintText: "Login",
                  hintStyle: TextStyle(
                    fontFamily: 'GothamHTF',
                    color: Colors.white
                  )

                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                initialValue: '123456',
                style: TextStyle(
                    fontFamily: 'GothamHTF',
                  
                  color: Colors.white
                ),
                obscureText: true,
                
                decoration: InputDecoration(
                  icon: Icon(Icons.lock_outline,color: Colors.white,),
                  focusColor: Colors.white,
                  hintText: "Senha",
                  hintStyle: TextStyle(
                    fontFamily: 'GothamHTF',
                    color: Colors.white
                  )

                ),
              ),
            ],
          )),
        ],
      ),
    ));
  }
}
