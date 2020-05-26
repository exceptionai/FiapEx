import 'package:flutter/material.dart';

class RowCallHistoryTile extends StatelessWidget {
  bool done;

  RowCallHistoryTile({Key key, this.done = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.symmetric(vertical: 8),
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed('/rowcall');
        },
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Desenvolvimento Cross Platform - 3SIT',
                style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Text('Data: ', style: TextStyle(fontSize: 14)),
                Text('24/05/2020', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              children: <Widget>[
                Text('Status: ', style: TextStyle(fontSize: 14)),
                Text('Pendente', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              children: <Widget>[
                Text('Alunos: ', style: TextStyle(fontSize: 14)),
                Text('40',
                    style:
                        TextStyle(fontSize: 16, color: Colors.lightBlueAccent)),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Ausentes: ',
                  style: TextStyle(fontSize: 14),
                ),
                Text('12',
                    style: TextStyle(fontSize: 16, color: Colors.redAccent)),
                SizedBox(
                  width: 10,
                ),
                Text('Presentes: ', style: TextStyle(fontSize: 14)),
                Text('28 ',
                    style: TextStyle(fontSize: 16, color: Colors.greenAccent)),
              ],
            )
          ],
        ),
        leading: done
            ? Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Image.asset(
                  'assets/images/presenteicone.png',
                  width: 40,
                ),
            )
            : Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Image.asset(
                  'assets/images/pendenteicone.png',
                  width: 40,
                ),
            ),
      ),
    );
  }
}
