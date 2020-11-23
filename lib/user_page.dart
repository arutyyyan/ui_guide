import 'package:flutter/material.dart';
import 'package:ui_guide/filter_screen.dart';
import 'package:ui_guide/icon_box.dart';
import 'touchable_block.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}
double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height * dividedBy;
}
double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width * dividedBy;
}

class UserPage extends StatefulWidget {
  bool byGoogle = false;
  String userName = '';
  static const String id = 'user_page';

  UserPage({this.byGoogle, this.userName});
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        toolbarHeight: screenHeight( context, dividedBy: 1/14),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              iconSize: 35.0,
              onPressed: () {
                if(widget.byGoogle)
                  GoogleSignIn().signOut();
                else
                  _auth.signOut();

                print("User Signed Out");
                Navigator.pop(context);
              }),
        ],
        title: Text('U Guide'),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: screenHeight( context, dividedBy: 4/14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconBox(title: 'SAVED UNI\'S', iconName: Icon(Icons.archive_rounded),),
                            SizedBox(height: 30.0),
                            IconBox(title: 'RANKING', iconName: Icon(Icons.graphic_eq_rounded)),
                          ],
                        ),
                        SizedBox(width: 10.0,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hello, ' + widget.userName + '!',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold),
                            ),
                            widget.byGoogle ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                loggedInUser.photoURL,
                              ),
                              radius: 60,
                              backgroundColor: Colors.transparent,
                            ) :
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: AssetImage('images/puppy.jpg'),
                            ),
                          ],
                        ),
                        SizedBox(width: 10.0,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconBox(title: 'SEARCH', iconName: Icon(Icons.search_rounded),
                              onPressed: () {
                                Navigator.pushNamed(context, FilterScreen.id);
                              },),
                            SizedBox(height: 30.0),
                            IconBox(title: 'CHANCE', iconName: Icon(Icons.grade))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight( context, dividedBy: 9/560)),
              TouchableBlock(title: 'ПОДОБРАТЬ СЕБЕ УНИВЕР', height: screenHeight( context, dividedBy: 9/70)),
              SizedBox(height: screenHeight( context, dividedBy: 9/560)),
              TouchableBlock(title: 'МАТЕРИАЛЫ ПО ПОДГОТОВКЕ', height: screenHeight( context, dividedBy: 9/70)),
              SizedBox(height: screenHeight( context, dividedBy: 9/560)),
              TouchableBlock(title: 'ПРОФ ОРИЕНТАЦИЯ ТЕСТ', height: screenHeight( context, dividedBy: 9/70)),
              SizedBox(height: screenHeight( context, dividedBy: 9/560)),
              TouchableBlock(title: 'ПОДГОТОВИТЬСЯ К ТЕСТАМ', height: screenHeight( context, dividedBy: 9/70))
            ],
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
