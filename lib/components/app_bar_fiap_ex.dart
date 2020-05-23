import 'package:FiapEx/components/drawer_fiap_ex.dart';
import 'package:flutter/material.dart';

class AppBarFiapEx extends StatelessWidget implements PreferredSizeWidget{
  
  final Widget action;
  const AppBarFiapEx({Key key, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
         backgroundColor: Theme.of(context).accentColor,
         elevation: 0, 
         centerTitle: true,
         iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
         actions: [
           action,
           
         ],
         title: Row(
           mainAxisSize: MainAxisSize.min,
           children: [
             Image.asset('assets/images/fiaplogo.png',height: 26,),
             SizedBox(width: 22,),
             Image.asset('assets/images/exceptionlogo.png',height: 26,),

           ],
         ),
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}