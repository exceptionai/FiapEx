import 'package:FiapEx/screens/assignment_screen.dart';
import 'package:FiapEx/screens/row_call_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fiap Ex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xffED145B),
        accentColor: const Color(0xff151819)
      ),
      onGenerateRoute: (RouteSettings settings){
        var routes = <String, WidgetBuilder>{
          '/': (BuildContext context) => RowCallScreen(),
          '/assignment': (BuildContext context) => AssignmentScreen(),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
      initialRoute: '/'
    );
  }
}
