import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import './Homepage.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => new _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 10,
      navigateAfterSeconds: new Userinfo(),
      title: new Text('DIPSmart',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 50.0
      ),),
      image: Image(image:AssetImage('assets/dps.jpg')),
      backgroundColor: Colors.green[300],
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("DIPP Smart"),
      loaderColor: Colors.red
    );
  }
}

class Userinfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User page')),
      drawer: ListView(
    // Important: Remove any padding from the ListView.
   
    children: <Widget>[
      DrawerHeader(
        child: Text('10-I'),
        decoration: BoxDecoration(
          color: Colors.teal,
        ),
      ),
      ListTile(
        title: Text('Questions & Answers',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),),
        dense: true,
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new Homepage()
            )
          );
        },
      ),
      ListTile(
        dense: true,
        title: Text('Book a Slot',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),),
        onTap: () {
          var snackBar = SnackBar(content: Text('Slot Booked Successfully!'),);
          Scaffold.of(context).showSnackBar(snackBar);
        },
      )
    ],
  ),
      body: new Stack(
      children: <Widget>[
        ClipPath(
          child: Container(color: Colors.black.withOpacity(0.8)),
          clipper: getClipper(),
        ),
        Positioned(
            width: 350.0,
            top: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: <Widget>[
                Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        //image: new Image(image: AssetImage('assets/dps.jpg'),),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black)
                        ])),
                SizedBox(height: 90.0),
                Text(
                  '10-I',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Student',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 25.0),
              ],
            ))
      ],
    ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}