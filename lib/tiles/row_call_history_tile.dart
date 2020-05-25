import 'package:flutter/material.dart';

class RowCallHistoryTile extends StatelessWidget {

  bool done;

  RowCallHistoryTile({Key key, this.done = false}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.of(context).pushNamed('/rowcall');
      },
      title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Desenvolvimento Cross Platform - 3SIT', style: TextStyle(fontSize:24)),
                      Row(
                        children: <Widget>[
                          Text('Status: ', style: TextStyle(fontSize: 18)),
                          Text('Pendente'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Alunos: ', style: TextStyle(fontSize: 14)),
                          Text('40', style: TextStyle(fontSize: 16) ),
                          SizedBox(width: 10,),
                          Text(
                            'Ausentes: ',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text('12', style: TextStyle(fontSize: 16)),
                          SizedBox(width: 10,),
                          Text('Presentes: ', style: TextStyle(fontSize: 14)),
                          Text('28 ', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Text('24/05/2020', style: TextStyle(fontSize: 15))
                    ],
                  ),
                  leading: done? Image.asset(
                    'assets/images/checkmark.png',
                    width: 40,
                  ) :
                  Image.asset(
                    'assets/images/pending.png',
                    width: 40,
                  ),
                  
              );
  }
}