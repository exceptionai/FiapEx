import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/components/drawer_fiap_ex.dart';
import 'package:FiapEx/models/roll_model.dart';
import 'package:FiapEx/models/student.dart';
import 'package:FiapEx/repository/student_repository.dart';
import 'package:FiapEx/services/row_call_service.dart';
import 'package:FiapEx/tiles/student_row_call_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RowCallScreen extends StatefulWidget {

  RollModel rollModel = new RollModel(); 
  RowCallScreen(this.rollModel);

  @override
  _RowCallScreenState createState() => _RowCallScreenState();
}

class _RowCallScreenState extends State<RowCallScreen> {
  StudentRepository studentRepository = new StudentRepository(); 
  RowCallService service = new RowCallService();
  List<int> presentStudents = List<int>();
  List<int> absentStudents = List<int>();
  bool loadingAbsents = true;
  bool loadingPresents = true;

  @override
  void initState() { 
    super.initState();
    getPresentStudents();
    getabsentStudents();
  }

  getPresentStudents() async{
    presentStudents = await service.getPresentStudents(rowCallId: widget.rollModel.id);
    setState(() {loadingPresents = false;});
  }

  getabsentStudents() async {
    absentStudents = await service.getAbsentStudents(rowCallId: widget.rollModel.id);
    setState(() {loadingAbsents = false;});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarFiapEx(
            action: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child:
                Icon(Icons.chevron_left,color: Theme.of(context).primaryColor,),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        )),
        drawer: DrawerFiapEx(
          route: '/',
        ),
        body: Container(
          color: Theme.of(context).accentColor,
          padding: EdgeInsets.only(right: 17.0),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 17.0, 0, 17.0),
                      child: Text(
                        "LISTA DE CHAMADA",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(17.0, 0, 0, 0),
                      child: Text(
                        "${widget.rollModel?.studentClass?.name[0]}° ANO - ${widget.rollModel?.studentClass?.name} - ${DateFormat('dd/MM/yyyy').format(widget.rollModel.date)}",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left:17.0, top:5.0, bottom: 30.0),
                      child: Text(
                        "${widget.rollModel.discipline?.name}",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<List<StudentModel>>(
                future: studentRepository.getAllStudentsByClass(widget.rollModel.idClass),
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && !loadingAbsents && !loadingPresents){
                    return ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics() ,
                      children: snapshot.data.map((student)=> StudentRowCallTile(
                        student: student, 
                        rowCall: widget.rollModel,
                        presentStudents: presentStudents, 
                        absentStudents: absentStudents,
                        onChanged: (bool presence){
                          if(presence){
                            setState(() {
                              if(!presentStudents.contains(student.id)){
                                presentStudents.add(student.id);
                              }
                              if(absentStudents.contains(student.id)){
                                absentStudents.remove(student.id);
                              }
                            });
                          }else{
                            setState(() {
                              if(!absentStudents.contains(student.id)){
                                absentStudents.add(student.id);
                              }
                              if(presentStudents.contains(student.id)){
                                presentStudents.remove(student.id);
                              }
                            });
                          }
                        })).toList(),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              widget.rollModel.done ? 
                 Container(
                   margin: EdgeInsets.only(top: 30),
                   padding: EdgeInsets.only(bottom: 30),
                   child: Column(
                     children: <Widget>[
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 15,
                          ),
                          Text('Presentes: '),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${presentStudents.length} ',
                            style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text('Ausentes: '),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${absentStudents.length} ',
                            style: TextStyle(
                                color: Colors.redAccent, fontWeight: FontWeight.bold),
                          ),
                        ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Data: ',style: TextStyle(fontSize: 18),),
                    Text("${DateFormat('dd/MM/yyyy').format(widget.rollModel.date)}")
                  ],
                )
                     ],
                   ),
                 )
                
              : Padding(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: doneRowCall() ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ButtonTheme(
                      buttonColor: Theme.of(context).primaryColor,
                      child: RaisedButton(
                          child: Text(
                            "Finalizar Chamada",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          onPressed: () => showConfirmDialog(context)),
                    ),
                  ],
                ) : Container(),
              ),
            ],
          ),
        ));
  }

  doneRowCall(){
    int presentsAmount = presentStudents.length;
    int absentsAmount = absentStudents.length;
    int studentsAmount = widget.rollModel.students.length;
    return studentsAmount == presentsAmount + absentsAmount;
  }

  showConfirmDialog(BuildContext context){
    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).accentColor,
        title: Text('Finalizar Chamada',style: TextStyle(color: Theme.of(context).primaryColor),),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topLeft: Radius.circular(15))),
        content: 
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Deseja realmente finalizar a chamada?', style: TextStyle(color: Colors.white),),
              SizedBox(height: 30,),
              Row(
                children: <Widget>[
                  Text('Alunos: ', style: TextStyle(color: Colors.white),),
                  Icon(Icons.person_outline,color: Colors.lightBlueAccent,),
                  Text('${widget.rollModel.students.length} ', style: TextStyle(color: Colors.lightBlueAccent),),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Presentes: ', style: TextStyle(color: Colors.white),),
                  Image.asset(
                    'assets/images/presenteicone.png',
                    height: 15, 
                  ),
                  Text(' ${presentStudents.length} ', style: TextStyle(color: Colors.greenAccent),),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Ausentes: ', style: TextStyle(color: Colors.white),),
                  Image.asset(
                    'assets/images/ausenteicone.png',
                    height: 15, 
                  ),
                  Text(' ${absentStudents.length} ', style: TextStyle(color: Colors.redAccent),),
                ],
              ),
              SizedBox(height: 15,),
              Text('Data: ${DateFormat('dd/MM/yyyy').format(widget.rollModel.date)} ', style: TextStyle(color: Colors.white),),
              
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(child: Text('Sim', style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontSize: 18)),onPressed: (){
                    finishRowCall();
                    },),
                  FlatButton(child: Text('Não', style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontSize: 18)),onPressed: (){Navigator.of(context).pop();},),
                ],
              ),
              
            ],
          ),
        elevation: 24,
        
      ),
      barrierDismissible: true);
  }

  finishRowCall() async{
    bool finished = await service.finishRowCall(rowCallId: widget.rollModel.id, date: widget.rollModel.date);
    if(finished){
      Navigator.of(context).pop(); 
      setState(() {
        widget.rollModel.done = true; 
      });

    }
  }
}
