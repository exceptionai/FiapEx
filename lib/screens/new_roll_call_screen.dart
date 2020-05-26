import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:flutter/material.dart';

class NewRowCallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFiapEx(
        action: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
            child: Image.asset('assets/images/entregatrabalhos.png', height: 26),
            onTap: () {
              Navigator.of(context).pushNamed('/assignment');
            },
          ),
        ),
      ),
    );
  }
}