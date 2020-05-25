import 'package:FiapEx/screens/Login/index.dart';
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
        switch (settings.name) {
          case '/assignment':
            return  MaterialPageRoute(
              builder: (_) => new AssignmentScreen(),
              settings: settings,
            );

          case '/':
            return MaterialPageRoute(
              builder: (_) => RowCallScreen(),
              settings: settings,
            );

          case '/login':
            return MyCustomRoute(
              builder: (_) => LoginScreen(),
              settings: settings
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
