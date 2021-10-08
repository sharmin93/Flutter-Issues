import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_issues/ui/flutter_issues_details.dart';
import 'package:flutter_issues/ui/pagination.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      AdaptiveTheme(
        light: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.red,
          accentColor: Colors.deepOrangeAccent,
        ),
        dark: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.red,
          accentColor: Colors.white,
        ),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(debugShowCheckedModeBanner: false,
          title: 'Adaptive Theme Demo',
          theme: theme,
          darkTheme: darkTheme,
          home: MyHomePage(),
          routes:  <String, WidgetBuilder>{
            '/issueDetails': (BuildContext context) => issueDetails(),
          },
        ),
      );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static var  pagination = Pagination();




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:
    AppBar(
      centerTitle: true,title: InkWell(onTap: (){

    },
        child: Text('Flutter Issues')),),
      body: pagination,

    );
  }
}
