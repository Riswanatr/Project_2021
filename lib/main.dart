import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

//Sign In page

class Signin extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final databaseReference = FirebaseDatabase.instance.reference();

  void createData() {
    databaseReference
        .child("flutterDevsTeam1")
        .set({'name': 'Misha mohan', 'description': 'Team Lead'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: new EdgeInsets.fromLTRB(20, 100, 20, 70),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.cover)),

                // Signin form

                child: new Card(
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: new Container(
                        height: 500,
                        width: 350,
                        padding: new EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/login.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: ListView(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 80),
                              alignment: Alignment.center,
                              child: Text(
                                'SignIn',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  labelText: 'Email ID',
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                obscureText: true,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  labelText: 'Passcode',
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: new Container(
                                height: 60,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  gradient: LinearGradient(
                                    colors: [Colors.blue, Colors.purple],
                                    begin: FractionalOffset.centerLeft,
                                    end: FractionalOffset.centerRight,
                                  ),
                                ),
                                child: FlatButton(
                                  child: Text(
                                    'SignIn',
                                    style: TextStyle(color: Colors.blue[200]),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FirebaseRealtimeDemoScreen()),
                                    );
                                  },
                                ),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Passcode()),
                                );
                              },
                              textColor: Colors.blue,
                              child: Text('Forgot Passcode'),
                            ),
                            Container(
                                child: Row(
                              children: <Widget>[
                                Text(
                                  'Do not have account?',
                                  style: TextStyle(color: Colors.purple),
                                ),
                                FlatButton(
                                  textColor: Colors.blue,
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ))
                          ],
                        ))))));
  }
}

//firebase

class FirebaseRealtimeDemoScreen extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    readData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Realtime Database Demo'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              child: Text('Create Data'),
              color: Colors.redAccent,
              onPressed: () {
                createData();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            SizedBox(
              height: 8,
            ),
            RaisedButton(
              child: Text('Read/View Data'),
              color: Colors.redAccent,
              onPressed: () {
                readData();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            SizedBox(
              height: 8,
            ),
            RaisedButton(
              child: Text('Update Data'),
              color: Colors.redAccent,
              onPressed: () {
                updateData();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            SizedBox(
              height: 8,
            ),
            RaisedButton(
              child: Text('Delete Data'),
              color: Colors.redAccent,
              onPressed: () {
                deleteData();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ],
        ),
      )), //center
    );
  }

  void createData() {
    databaseReference
        .child("flutterDevsTeam1")
        .push()
        .set({'name': 'Dayana edwin', 'description': 'Team Member'});
  }

  void readData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  void updateData() {
    databaseReference.child('flutterDevsTeam1').update({'description': 'ABC'});
    databaseReference
        .child('flutterDevsTeam2')
        .update({'description': 'ABCDE'});
    databaseReference
        .child('flutterDevsTeam3')
        .update({'description': 'EFGHI'});
  }

  void deleteData() {
    databaseReference.child('flutterDevsTeam1').remove();
    databaseReference.child('flutterDevsTeam2').remove();
    databaseReference.child('flutterDevsTeam3').remove();
  }
}

//SignUp page

class _State extends State<MyApp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: new EdgeInsets.fromLTRB(20, 100, 20, 70),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.cover)),

                // Signup form

                child: new Card(
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: new Container(
                        height: 500,
                        width: 350,
                        padding: new EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/login.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: ListView(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                              alignment: Alignment.center,
                              child: Text(
                                'SignUp',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  labelText: 'Name',
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  labelText: 'Email ID',
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                obscureText: true,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  labelText: 'Passcode',
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: new Container(
                                height: 60,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  gradient: LinearGradient(
                                    colors: [Colors.blue, Colors.purple],
                                    begin: FractionalOffset.centerLeft,
                                    end: FractionalOffset.centerRight,
                                  ),
                                ),
                                child: FlatButton(
                                  child: Text(
                                    'SignUp',
                                    style: TextStyle(color: Colors.blue[200]),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                                child: Row(
                              children: <Widget>[
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(color: Colors.purple),
                                ),
                                FlatButton(
                                  textColor: Colors.blue,
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Signin()),
                                    );
                                  },
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ))
                          ],
                        ))))));
  }
}

class Passcode extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: new EdgeInsets.fromLTRB(20, 100, 20, 70),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.cover)),

                // Forgot passcode form

                child: new Card(
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: new Container(
                        height: 500,
                        width: 350,
                        padding: new EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/login.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: ListView(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 80),
                              alignment: Alignment.center,
                              child: Text(
                                'Forgot Passcode',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  labelText: 'Email ID',
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: new Container(
                                height: 60,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  gradient: LinearGradient(
                                    colors: [Colors.blue, Colors.purple],
                                    begin: FractionalOffset.centerLeft,
                                    end: FractionalOffset.centerRight,
                                  ),
                                ),
                                child: FlatButton(
                                  child: Text(
                                    'Get Passcode',
                                    style: TextStyle(color: Colors.blue[200]),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ))))));
  }
}

//Edit name and Email Id

class Edit extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: new EdgeInsets.fromLTRB(20, 100, 20, 70),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.cover)),

                // Forgot passcode form

                child: new Card(
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: new Container(
                        height: 500,
                        width: 350,
                        padding: new EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/login.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: ListView(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
                              alignment: Alignment.center,
                              child: Text(
                                'Edit User details',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  labelText: 'User',
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  labelText: 'user@gmail.com',
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: new Container(
                                height: 60,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  gradient: LinearGradient(
                                    colors: [Colors.blue, Colors.purple],
                                    begin: FractionalOffset.centerLeft,
                                    end: FractionalOffset.centerRight,
                                  ),
                                ),
                                child: FlatButton(
                                  child: Text(
                                    'Save',
                                    style: TextStyle(color: Colors.blue[200]),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ))))));
  }
}

//Settings

class Settings extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: new EdgeInsets.fromLTRB(20, 100, 20, 70),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.cover)),

                // Forgot passcode form

                child: new Card(
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: new Container(
                        height: 500,
                        width: 350,
                        padding: new EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/login.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: ListView(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 50),
                              alignment: Alignment.center,
                              child: Text(
                                'Settings',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(0),
                              child: new Column(
                                children: <Widget>[
                                  FlatButton(
                                    child: Row(children: <Widget>[
                                      Icon(Icons.account_circle_sharp,
                                          color: Colors.purple),
                                      Text(
                                        'Account',
                                        style: TextStyle(color: Colors.purple),
                                      ),
                                    ]),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Edit()),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Icon(Icons.notifications,
                                      color: Colors.purple),
                                  Text(
                                    'Notifications',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                  Switch(
                                    value: isSwitched,
                                    onChanged: (value) {},
                                    activeTrackColor: Colors.blue,
                                    activeColor: Colors.purple,
                                  ),
                                ]))),
                            Container(
                              padding: EdgeInsets.all(0),
                              child: new Column(
                                children: <Widget>[
                                  FlatButton(
                                    child: Row(children: <Widget>[
                                      Icon(Icons.logout, color: Colors.purple),
                                      Text(
                                        'Logout',
                                        style: TextStyle(color: Colors.purple),
                                      ),
                                    ]),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signin()),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))))));
  }
}

/// Home page

class Home extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
          child: Container(
              padding: new EdgeInsets.fromLTRB(20, 100, 20, 0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover)),
              child: new Card(
                  shadowColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: new Container(
                    width: 350,
                    padding: new EdgeInsets.fromLTRB(0, 15, 0, 15),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/logi.png"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    child: new Container(
                      padding: new EdgeInsets.all(10),
                      child: new Center(
                        child: new Column(
                          children: <Widget>[
                            new Card(
                              shadowColor: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: new Container(
                                height: 250,
                                width: 350,
                                padding: new EdgeInsets.fromLTRB(5, 50, 5, 10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/voice.png"),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: new Column(
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'Voice Commands',
                                        style: TextStyle(
                                          fontSize: 28.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Voice_commands()),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            new Card(
                              shadowColor: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: new Container(
                                height: 250,
                                width: 350,
                                padding: new EdgeInsets.fromLTRB(5, 50, 5, 10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/map.png"),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: new Column(
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'Indoor Mapping',
                                        style: TextStyle(
                                          fontSize: 28.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  IndoorMapping()),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            new Card(
                              shadowColor: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: new Container(
                                height: 250,
                                width: 350,
                                padding: new EdgeInsets.fromLTRB(5, 50, 5, 10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/tutorial.png"),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: new Column(
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'Tutorials',
                                        style: TextStyle(
                                          fontSize: 28.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Tutorials()),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }

  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Settings(),
    Voice_commands(),
    IndoorMapping(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Material(
          color: Colors.white,
          child: new SafeArea(
              child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: TabBar(
              controller: _tabController,
              unselectedLabelColor: Colors.tealAccent[700],
              indicatorWeight: 0.01,
              labelColor: Colors.tealAccent,
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.home,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.settings,
                  ),
                ),
                Tab(
                  icon: Icon(Icons.mic),
                ),
                Tab(
                  icon: Icon(Icons.location_on),
                ),
              ],
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          )),
        ),
      ),
    );
  }
}

//Voice commands

class Voice_commands extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSwitched = false;

  TextEditingController addControler = new TextEditingController();
  createAlertDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'New Command',
              style: TextStyle(color: Colors.purple),
            ),
            content: TextField(
              controller: addControler,
            ),
            actions: [
              MaterialButton(
                elevation: 5.0,
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.purple),
                ),
                onPressed: () {
                  Navigator.of(context).pop(addControler.text.toString());
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: new EdgeInsets.fromLTRB(20, 100, 20, 70),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.cover)),
                child: new Card(
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: new Container(
                        height: 500,
                        width: 350,
                        padding: new EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/login.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: ListView(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                              alignment: Alignment.center,
                              child: Text(
                                'Voice commands',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Icon(Icons.play_arrow, color: Colors.purple),
                                  Text(
                                    'Start',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.add_box,
                                        color: Colors.purple),
                                    onPressed: () {
                                      createAlertDialogue(context);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.list_outlined,
                                        color: Colors.purple),
                                    onPressed: () {},
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Icon(Icons.pause, color: Colors.purple),
                                  Text(
                                    'Stop',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.add_box,
                                        color: Colors.purple),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.list_outlined,
                                        color: Colors.purple),
                                    onPressed: () {},
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Icon(Icons.north, color: Colors.purple),
                                  Text(
                                    'Forward',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.add_box,
                                        color: Colors.purple),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.list_outlined,
                                        color: Colors.purple),
                                    onPressed: () {},
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Icon(Icons.south, color: Colors.purple),
                                  Text(
                                    'Backward',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.add_box,
                                        color: Colors.purple),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.list_outlined,
                                        color: Colors.purple),
                                    onPressed: () {},
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Icon(Icons.arrow_left, color: Colors.purple),
                                  Text(
                                    'Left',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.add_box,
                                        color: Colors.purple),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.list_outlined,
                                        color: Colors.purple),
                                    onPressed: () {},
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Icon(Icons.arrow_right, color: Colors.purple),
                                  Text(
                                    'Right',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.add_box,
                                        color: Colors.purple),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.list_outlined,
                                        color: Colors.purple),
                                    onPressed: () {},
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Icon(Icons.rotate_90_degrees_ccw,
                                      color: Colors.purple),
                                  Text(
                                    'Turn',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.add_box,
                                        color: Colors.purple),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.list_outlined,
                                        color: Colors.purple),
                                    onPressed: () {},
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Icon(Icons.chevron_right_outlined,
                                      color: Colors.purple),
                                  Text(
                                    'Go to',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.add_box,
                                        color: Colors.purple),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.list_outlined,
                                        color: Colors.purple),
                                    onPressed: () {},
                                  ),
                                ]))),
                          ],
                        ))))));
  }
}

//indoor mapping

class IndoorMapping extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: new EdgeInsets.fromLTRB(20, 100, 20, 70),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.cover)),
                child: new Card(
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: new Container(
                      height: 500,
                      width: 350,
                      padding: new EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/login.png"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                            alignment: Alignment.center,
                            child: Text(
                              'Indoor mapping',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () => {},
                            color: Colors.white,
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.location_on, color: Colors.purple),
                                Text(
                                  "Locate Now",
                                  style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 250,
                            width: 250,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/indoor_map.jpg"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )))));
  }
}

// Tutorials

class Tutorials extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: new EdgeInsets.fromLTRB(20, 100, 20, 70),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.cover)),
                child: new Card(
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: new Container(
                        height: 500,
                        width: 350,
                        padding: new EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/login.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: ListView(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                              alignment: Alignment.center,
                              child: Text(
                                'Tutorials',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Text(
                                    'Voice Commands\n',
                                    style: TextStyle(
                                        color: Colors.purple,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Text(
                                    '''1.Start- The wheelchair starts to move.''',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Text(
                                    '2.Stop- The wheelchair comes to \n   an immediate halt.',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Text(
                                    '''3.Forward - The wheelchair starts \n   moving in the direction that the \n   chair is facing.''',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Text(
                                    '''4.Backward - The wheelchair starts\n   moving  in the direction opposite\n   to the chair facing.''',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Text(
                                    '''5.Left - The wheelchair makes a left \n    turn.''',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Text(
                                    '''6.Right - The wheelchair makes a right \n    turn.''',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Text(
                                    '''7.Turn - The wheelchair begins to rotate''',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Text(
                                    '''8.Go to - The wheelchair moves to \n  the location given by the user.''',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Text(
                                    'Indoor mapping',
                                    style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]))),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Container(
                                    child: Row(children: <Widget>[
                                  Text(
                                    '''1.locate now shows the  \n   current location of wheelchair''',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ]))),
                          ],
                        ))))));
  }
}
