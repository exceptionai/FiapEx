import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:flutter/material.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFiapEx(),
      body: Container(
          color: Color(0xffff1819),
      ),
    );
  }
}