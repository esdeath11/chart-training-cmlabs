import 'package:flutter/material.dart';
import 'package:untitled1/page/line.dart';


void main(){
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context)=> firstPage(),
      },
    )
  );
}


class firstPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid 19'),
      ),
      body: LineChartPage(),
    );
  }
}
