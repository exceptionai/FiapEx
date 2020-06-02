import 'package:FiapEx/models/roll_model.dart';
import 'package:FiapEx/models/student.dart';
import 'package:FiapEx/services/row_call_service.dart';
import 'package:flutter/material.dart';

class StudentRowCallTile extends StatefulWidget {
  final StudentModel student;
  final RollModel rowCall;
  final List<int> presentStudents;
  final List<int> absentStudents;
  final Function(bool presence) onChanged;

  StudentRowCallTile(
      {this.student, this.rowCall, this.presentStudents, this.absentStudents, this.onChanged});

  @override
  _StudentRowCallTileState createState() => _StudentRowCallTileState();
}

class _StudentRowCallTileState extends State<StudentRowCallTile> {
  final RowCallService service = new RowCallService();
  bool presence;

  @override
  void didUpdateWidget(StudentRowCallTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    getPresence();
  }

  @override
  void initState() { 
    super.initState();
    getPresence();
  }

  getPresence(){

    setState(() {
      if(widget.presentStudents.contains(widget.student.id)){
        presence = true;
      }else if(widget.absentStudents.contains(widget.student.id)){
        presence = false;
      }else{
        presence = null;
      }
    });
  }

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
                  presence == true
                      ? 'assets/images/presenteicone.png'
                      : presence == false
                          ? 'assets/images/ausenteicone.png'
                          : 'assets/images/pendenteicone.png',
                  height: 26,
                ),
              ),
              InkWell(
                onTap: () {
                  _showModalStudent(context);
                },
                child: Text(
                  "${widget.student.name}",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          widget.rowCall.done
              ? Container()
              : Row(
                  children: <Widget>[
                    InkWell(
                      child: Image.asset(
                        'assets/images/presenteicone.png',
                        height: 20,
                      ),
                      onTap: () {
                        setPresence(true, context);
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    InkWell(
                      child: Image.asset(
                        'assets/images/ausenteicone.png',
                        height: 20,
                      ),
                      onTap: () {
                        setPresence(false, context);
                      },
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  _showModalStudent(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        backgroundColor: Theme.of(context).accentColor,
        builder: (BuildContext context) {
          return Container(
            height: 420,
            padding: EdgeInsets.all(15.0),
            child: ListView(
              children: <Widget>[
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/${widget.student.imgUrl}'),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('${widget.student.name.toUpperCase()}'),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Text('Presença: '),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '2 ',
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text('Ausência: '),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '35 ',
                      style: TextStyle(
                          color: Colors.redAccent, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Text('Status${widget.rowCall.done ? '' : ' Atual'}: '),
                    SizedBox(
                      width: widget.rowCall.done ? 90 : 40,
                    ),
                    Image.asset(
                      presence == true
                          ? 'assets/images/presenteicone.png'
                          : presence == false
                              ? 'assets/images/ausenteicone.png'
                              : 'assets/images/pendenteicone.png',
                      width: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(presence == true
                        ? 'Presente '
                        : presence == false? 'Ausente'
                        : 'Pendente '),
                  ],
                ),
                widget.rowCall.done
                    ? Container()
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FlatButton(
                            padding: EdgeInsets.zero,
                            child: Image.asset(
                              'assets/images/presenteicone.png',
                              width: 35,
                            ),
                            onPressed: () {
                              setPresence(true, context);

                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            padding: EdgeInsets.zero,
                            child: Image.asset(
                              'assets/images/ausenteicone.png',
                              width: 35,
                            ),
                            onPressed: () {
                              setPresence(false, context);
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

  void setPresence(bool presenceSet, BuildContext context) async {
    bool success = await service.setPresence(presenceSet,
        studentId: widget.student.id, rowCallId: widget.rowCall.id);
    if(success){
      setState(() {
        this.presence = presenceSet;
      });
      widget.onChanged(presence);
    }
  }
}
