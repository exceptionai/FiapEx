import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/class_model.dart';
import '../repository/class_repository.dart';

enum OrderOptions{
  orderaz,
  orderza
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ClassRepository classRepository = ClassRepository(); 
  List<ClassModel> classes = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllClasses();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Turmas"),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                child:Text("Ordernar de A-Z"),
                value: OrderOptions.orderaz,
              ),const PopupMenuItem<OrderOptions>(
                child:Text("Ordernar de Z-A"),
                value: OrderOptions.orderza,
              ),
            ],
            onSelected: _orderList,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          onPressed: null,//showContactPage,
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
      body: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: classes.length,
          itemBuilder: (context,index){
            return _contactCard(context,index);
          }
        )
      );

  }
  Widget _contactCard(BuildContext context, int index){
      return GestureDetector(
        child:Card(
          child:Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children:<Widget>[
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration:BoxDecoration(
                    shape:BoxShape.circle,
                    image: DecorationImage(
                      image:AssetImage("images/person.png"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left:10.0),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>[
                      Text(classes[index].name ?? "",
                        style:TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),
                      ),
                      Text(classes[index].id ?? "",
                        style:TextStyle(fontSize:18.0),
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
        onTap:(){
          _showOptions(context,index);
        },
      );
    }

    /*void _showContactPage({ClassModel class}) async{
      final receivedClass = await Navigator.push(context,
        MaterialPageRoute(builder: (context)=>ContactPage(contact: class,))
      );
      if (recContact != null){
        if(contact != null){
          print('update');
          await helper.updateContact(recContact);
        }else{
          await helper.saveContact(recContact);
        }
        _getAllContacts();
      }
    }*/
    void _getAllClasses(){
      classRepository.getAllClasses().then((list){
        setState(() {
          classes = list;  
        });
      });
    } 

    void _showOptions(BuildContext context, int index){
      showModalBottomSheet(
        context: context,
        builder: (context){
          return BottomSheet(
            onClosing: (){},
            builder: (context){
              return Container(
                padding: EdgeInsets.all(10.0),
                child:Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        child:Text("Ligar",
                          style:TextStyle(color:Colors.red,fontSize: 20.0)),
                        onPressed: (){
                          launch("tel:40020022");
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        child:Text("Editar",
                          style:TextStyle(color:Colors.red,fontSize: 20.0)),
                        onPressed: (){
                          Navigator.pop(context);
                          //showContactPage(contact: contacts[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        child:Text("Excluir",
                          style:TextStyle(color:Colors.red,fontSize: 20.0)),
                        onPressed: (){
                          /*helper.deleteContact(contacts[index].id);
                          setState(() {
                            contacts.removeAt(index);
                            Navigator.pop(context);
                          });*/
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    void _orderList(OrderOptions result){
      switch(result){
        case OrderOptions.orderaz:
          classes.sort((a,b) {
            return a.name.toLowerCase().compareTo(b.name.toLowerCase());
          });
          break;
        case OrderOptions.orderza:
            classes.sort((a,b) {
              return b.name.toLowerCase().compareTo(a.name.toLowerCase());
          });
          break;
      }
      setState(() {
        
      });
    }

}