import 'package:FiapEx/models/student.dart';
import 'package:flutter/material.dart';

class StudentRowCallTile extends StatelessWidget {
  final StudentModel student;
  const StudentRowCallTile(this.student);

  @override
  Widget build(BuildContext context) {
    return Container( 
      padding: EdgeInsets.fromLTRB(17.0, 15.0, 7.0, 1.0),
      child: Row(
        children: <Widget>[
          Row(                      
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 1.0, 17.0, 1.0),
                child: Image.asset(
                  'assets/images/pendenteicone.png',
                  height: 26,
                ),
              ),
              InkWell(
                onTap: (){
                  _showModalStudent(context);
                },
                              child: Text(
                  "${student.name}",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Row(
            children: <Widget>[
              InkWell(
                child: Image.asset(
                  'assets/images/presenteicone.png',
                  height: 20, 
                ),
                onTap: () {},
              ),
              SizedBox(
                width: 20.0,
              ),
              InkWell(
                child: Image.asset(
                  'assets/images/ausenteicone.png',
                  height: 20,
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }


  _showModalStudent(BuildContext context){
    showModalBottomSheet(context: context,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
      ),
           
    ),backgroundColor: Theme.of(context).accentColor, builder: (BuildContext context){
      return Container(
        height: 800,
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),

              borderRadius: BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                  image: AssetImage('assets/images/${student.imgUrl}'),
                  fit: BoxFit.cover

                )
              ),
            ),
            SizedBox(height: 20,),
            Text('${student.name.toUpperCase()}'),
            SizedBox(height: 25,),
            Row(
              children: <Widget>[
                SizedBox(width: 15,),
                Text('Presença: '),
                SizedBox(width: 10,),
                Text('2 ',style: TextStyle(color: Colors.greenAccent,fontWeight: FontWeight.bold),),
                
                SizedBox(width: 40,),
                Text('Ausência: '),
                SizedBox(width: 10,),
                Text('35 ',style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),),
                
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: <Widget>[
                SizedBox(width: 15,),
                Text('Status Atual: '),
                SizedBox(width: 40,),
                Image.asset('assets/images/pendenteicone.png',width: 35,),
                SizedBox(width: 10,),
                Text('Pendente '),

              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                
                FlatButton(
                  padding: EdgeInsets.zero,
                  child: Image.asset('assets/images/presenteicone.png',width: 35,),
                  onPressed: (){

                    // TODO: service/repository set as present

                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  padding: EdgeInsets.zero,
                  child: Image.asset('assets/images/ausenteicone.png',width: 35,),
                  onPressed: (){

                    // TODO: service/repository set as absent

                    Navigator.of(context).pop();
                    
                  },
                ),
              ],
            )

          ],
        ),
      );
    });
  }
}