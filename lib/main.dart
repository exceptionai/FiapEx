import 'package:FiapEx/screens/assignment_deliveries_screen.dart';
import 'package:FiapEx/screens/assignment_screen.dart';
import 'package:FiapEx/screens/login_screen.dart';
import 'package:FiapEx/screens/new_roll_call_screen.dart';
import 'package:FiapEx/screens/row_call_history_screen.dart';
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
      theme: ThemeData(
        textTheme:  TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white,fontSize: 20),
        ),
        
        primaryColor: const Color(0xffED145B),
        accentColor: const Color(0xff151819),
        fontFamily: 'GothamHTF',
        hintColor: Colors.white,
      
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings){
        switch (settings.name) {
          case '/assignment':
            return  MaterialPageRoute(
              builder: (_) => new AssignmentScreen(),
              settings: settings,
            );
          
          case '/assignment_deliveries':
            return  MaterialPageRoute(
              builder: (_) => new AssignmentDeliveriesScreen(assignment: settings.arguments),
              settings: settings,
            );

          case '/':
            return MaterialPageRoute(
              builder: (_) => RowCallHistoryScreen(),
              settings: settings,
            );

          case '/rowcall':
            return MyCustomRoute(
              builder: (_) => RowCallScreen(),
              settings: settings
            );

          case '/login':
            return MyCustomRoute(
              builder: (_) => LoginScreen(),
              settings: settings
            );
          case '/new':
            return MyCustomRoute(
              builder: (_) => NewRowCallScreen(),
              settings: settings
            );
          default: 
            return MaterialPageRoute(
              builder: (_) => RowCallScreen(),
              settings: settings,
            );
        }
      },
      initialRoute: '/login'
    );
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.name == '/login') return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}
