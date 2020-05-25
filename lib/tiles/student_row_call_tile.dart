import 'package:flutter/material.dart';

class StudentRowCallTile extends StatelessWidget {
  const StudentRowCallTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff151819),
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
              Text(
                "Alisson Chabaribery",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
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
}