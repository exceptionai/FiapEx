import 'package:FiapEx/components/on_boarding/src/on_boarding_me.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: OnboardingMe(
      /// Number of Pages for the screens
      numOfPage: 5,

      /// No of colors you want for your screen
      noOfBackgroundColor: 4,

      /// List of background colors => In descending order
      bgColor: [
        Theme.of(context).accentColor,
        Theme.of(context).accentColor,
        Theme.of(context).accentColor,
        Theme.of(context).primaryColor,
      ],

      /// List of  Call-to-action action
      ctaText: [
        'Pular',
        'Começar'
      ],

      /// List that maps your screen content
      screenContent: [
        {
          "Scr 1 Heading" : "Fiap EX",
          "Scr 1 Sub Heading" : "Gerencie chamadas e avalie trabalhos num único APP.",
          "Scr 1 Image Path" : "assets/images/fiapexlogo.png",
        },
        {
          "Scr 2 Heading" : "Listas de Chamadas",
          "Scr 2 Sub Heading" : "Crie novas chamadas, veja o histórico de chamadas realizadas e ao apertar em um aluno veja detalhes sobre ele!",
          "Scr 2 Image Path" : "assets/images/rollcallicon.png",
        },
        {
          "Scr 3 Heading" : "Não deixe nada pendente!",
          "Scr 3 Sub Heading" : "Este icone irá aparecer em casos pendentes. No caso das chamadas, caso haja alunos pendentes você não consegue fechar uma chamada.",
          "Scr 3 Image Path" : "assets/images/pendenteicone.png",
        },
        {
          "Scr 4 Heading" : "Entrega de Trabalhos",
          "Scr 4 Sub Heading" : "Avalie os trabalhos e caso desejar adicione também um comentário. É possível também adicionar anotações sobre uma entrega.",
          "Scr 4 Image Path" : "assets/images/assignmentdeliveryicon.png",
        },
        {
          "Scr 5 Heading" : "Tudo certo!",
          "Scr 5 Sub Heading" : "Comece agora a experimentar esta nova experiência.",
          "Scr 5 Image Path" : "assets/images/presenteicone.png",
        },
      ],

      /// Bool for Circle Page Indicator
      isPageIndicatorCircle: true,

      /// Home Screen Route that lands after on-boarding
      homeRoute: '/',
    ),
    );
  }
}