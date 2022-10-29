import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mento_mind_assignment/views/screen1.dart';
import 'package:mento_mind_assignment/views/screen2.dart';

class MyRoutes {
  static const screen1 = '/screen1';
  static const screen2 = '/screen2';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case screen1:
        return MaterialPageRoute(builder: (context) => Screen1());
      case screen2:
        return MaterialPageRoute(builder: (context) => Screen2());
    }

    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
            body: AlertDialog(
          title: Text('Are you sure want to exit'),
          actions: [
            TextButton(
              onPressed: () {
               MaterialPageRoute(builder: (context) => Screen1());
              
              },
              child: Text('Go Back',style: TextStyle(color: Colors.green),),
            ),
          ],
        ));
      },
    );
  }
}
