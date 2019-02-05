import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome To DIPP Smart'),
        ),
        body: new StreamBuilder(
          stream: Firestore.instance.collection('QandA').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return new GridView.count(
              crossAxisCount: 1,
              childAspectRatio: 2.0,
              padding: const EdgeInsets.all(10.0),
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Center(
                  child: Card(
                    margin: EdgeInsets.all(2.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        
                        ListTile(
                            title: new Text(
                              'Q: ' + document['Questions'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.0),
                            ),
                            enabled: true,
                            subtitle: Text('Created on 23 January, 2019'),
                            leading: new Image(
                              image: AssetImage('assets/dps.jpg'),
                              width: 50.0,
                              height: 50.0,
                            ),
                            
                            onTap: () {
                              String Ques = document['Questions'];
                              String Ans = document['Answers'];
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new MaterialApp(
                                          home: Scaffold(
                                            appBar: AppBar(
                                              title: Text(Ques),
                                            ),
                                            body: GridView.count(
                                              crossAxisCount: 1,
                                              childAspectRatio: 2.0,
                                              padding: const EdgeInsets.all(10.0),
                                              children: <Widget>[
                                                Center(
                                              child: Card(
                                                margin: EdgeInsets.all(2.0),
                                                elevation: 4.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
                                                child: Column(
                                                  children: <Widget>[
                                                     ListTile(
                                                      leading: new Image(
                                                        image: AssetImage('assets/dps.jpg'),
                                                        width: 50.0,
                                                        height: 50.0,
                                                        ),
                                                        title: new Text(
                                                        'Q: ' + Ques,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold, fontSize: 15.0),
                                                      ),
                                                      subtitle: Text('Created on 23 January, 2019'),
                                                    ),
                                                    ButtonTheme.bar( // make buttons use the appropriate styles for cards
                                                      child: ButtonBar(
                                                           children: <Widget>[
                                                                FlatButton(
                                                                  child: const Text('Upvote'),
                                                                   onPressed: () {var snackBar = SnackBar(content: Text('Upvoted Successfully!'),);
                                                                   Scaffold.of(context).showSnackBar(snackBar);},
                                                                   ),
                                  FlatButton(
                                    child: const Text('Downvote'),
                                    onPressed: () {var snackBar = SnackBar(content: Text('Downvoted Successfully!'),);
                                                    Scaffold.of(context).showSnackBar(snackBar);},
                                  ),
                                  FlatButton(
                                    child: const Text('Answer'),
                                    onPressed: () {}
                                  ),

                      ],
                    ),
                  ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 10.0,
                                              width: 30.0,
                                              child: Text('Answer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),),
                                            ),
                                            Center(
                                              child: Card(
                                                margin: EdgeInsets.all(2.0),
                                                elevation: 4.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                                child: Column(
                                                  children: <Widget>[
                                                     ListTile(
                                                      leading: new Image(
                                                        image: AssetImage('assets/dps.jpg'),
                                                        width: 50.0,
                                                        height: 50.0,
                                                        ),
                                                        title: new Text(
                                                        'A: ' + Ans,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold, fontSize: 15.0),
                                                      ),
                                                      subtitle: Text('Created on 23 January, 2019'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                              ],
                                            )
                                          ),
                                        )),
                              );
                            }),
                            ButtonTheme.bar( // make buttons use the appropriate styles for cards
                            child: ButtonBar(
                                children: <Widget>[
                                  FlatButton(
                                    child: const Text('Upvote'),
                                    onPressed: () {var snackBar = SnackBar(content: Text('Upvoted Successfully!'),);
                                                    Scaffold.of(context).showSnackBar(snackBar);},
                                  ),
                                  FlatButton(
                                    child: const Text('Downvote'),
                                    onPressed: () {var snackBar = SnackBar(content: Text('Downvoted Successfully!'),);
                                                    Scaffold.of(context).showSnackBar(snackBar);},
                                  ),
                                  FlatButton(
                                    child: const Text('Answer'),
                                    onPressed: () {},
                                  ),

                      ],
                    ),
                  ),
                      ]
                  )
                )
                  );
                  }).toList(),
            );
          },
        ),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.add),
            backgroundColor: new Color(0xFFE57373),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new UploadFormField()),
              );
            }));
  }
}

// UPLOAD TO FIRESTORE

class UploadFormField extends StatefulWidget {
  @override
  _UploadFormFieldState createState() => _UploadFormFieldState();
}

class _UploadFormFieldState extends State<UploadFormField> {
  GlobalKey<FormState> _key = GlobalKey();
  bool _validate = false;
  String question;
  String answer;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Upload'),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(10.0),
            child: new Form(
              key: _key,
              autovalidate: _validate,
              child: FormUI(),
            ),
          ),
        ),
      ),
    );
  }

  Widget FormUI() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Question'),
            validator: validateQuestion,
            onSaved: (String val) {
              question = val;
            }),
        new SizedBox(height: 20.0, width: 20.0,),
        new TextFormField(
              decoration: new InputDecoration(hintText: 'Put your answer here...'),
              maxLines: 20,
              validator: validateAnswer,
              onSaved: (String val) {
                answer = val;
              }),
        new SizedBox(height: 40.0),
        new RaisedButton(
          onPressed: _sendToServer,
          child: new Text('Upload'),
        )
      ],
    );
  }

  String validateQuestion(String value) {
    String patttern = r'(^[a-zA-Z? ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Question is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Question must be a-z and A-Z ";
    }
    return null;
  }

  String validateAnswer(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Answer is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Answer must be a-z and A-Z";
    }
    return null;
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      //No error in validator
      _key.currentState.save();
      Firestore.instance.runTransaction((Transaction transaction) async {
        CollectionReference reference = Firestore.instance.collection('QandA');

        await reference.add({"Questions": "$question","Answers": "$answer"});
      });
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => Homepage()),
      );
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}

