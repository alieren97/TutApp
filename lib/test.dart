import 'package:advanced_flutter/app/app.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({key});

  void updateAppState() {
    MyApp.instance.appState = 0;
  }
  void getAppState() {
    print(MyApp.instance.appState);
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}