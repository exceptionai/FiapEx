import 'package:flutter/material.dart';

class AppBarFiapEx extends StatelessWidget implements PreferredSizeWidget{
  const AppBarFiapEx({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
         backgroundColor: Theme.of(context).accentColor,
         elevation: 0, 
         centerTitle: true,
         leading: Row(
           children: [
             SizedBox(width: 10,),
             CircleAvatar(
               backgroundImage: AssetImage('assets/images/profilepic.jpg'),
              ),
           ],
         ),
         actions: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: InkWell(
                 child: Image.asset('assets/images/entregatrabalhos.png',
                          height: 26),
                onTap: (){
                  Navigator.of(context).pushReplacementNamed('/assignment');
                },
              ),
             ),
           
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