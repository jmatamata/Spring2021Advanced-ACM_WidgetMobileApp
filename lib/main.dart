import 'package:acm_widget_mobile_app/alvins_page.dart';
import 'package:acm_widget_mobile_app/home.dart';
import 'package:acm_widget_mobile_app/jorges_page.dart';
import 'package:acm_widget_mobile_app/weather_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  int index = 0;
  List<Widget> list = [HomePage(), WeatherPage(), AlvinsPage(), JorgesPage()];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        // This is the theme of your application.

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color.fromRGBO(1, 113, 161, 1.0),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('ACM Flutter Application'),
        ),
        body: list[index],
        drawer: NavDrawer(onTap: (ctx,i){
          setState(() {
            index = i;
            Navigator.pop(ctx);
          });
        }),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  final Function onTap;

  NavDrawer({this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Color.fromRGBO(1, 85, 138, 1.0)),
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        width: 140,
                        height: 130,
                        child: Image(
                          image: AssetImage('assets/acm_logo.png'),
                        ))
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => onTap(context, 0),
            ),
            Divider(height: 5),
            ListTile(
              leading: Icon(Icons.cloud),
              title: Text('Weather'),
              onTap: () => onTap(context, 1),
            ),
            Divider(height: 5),
            ListTile(
              leading: Icon(Icons.alarm),
              title: Text('Alvin'),
              onTap: () => onTap(context, 2),
            ),
            Divider(height: 5),
            ListTile(
              leading: Icon(Icons.fastfood),
              title: Text('Jorge'),
              onTap: () => onTap(context, 3),
            ),
          ],
        ),
      ),
    );
  }
}
