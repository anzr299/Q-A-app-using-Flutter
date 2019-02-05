import 'package:flutter/material.dart';
import './splash.dart';
import './Homepage.dart';

void main() { // 1
  runApp( // 2
    new MaterialApp( //3
      home: new splash(), //4
      routes: <String, WidgetBuilder> { //5
        '/splash': (BuildContext context) => new splash(), //6
        '/Homepage' : (BuildContext context) => new Homepage(), //7
      },
    )
  );
}

