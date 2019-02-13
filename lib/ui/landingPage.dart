import 'package:flutter/material.dart';
import 'package:hamrah/model/user.dart';
import 'package:hamrah/ui/cardsPage.dart';
import 'package:hamrah/ui/homePage.dart';
import 'package:hamrah/ui/loginPage.dart';
import 'package:hamrah/ui/signUpPage.dart';
import 'package:hamrah/util/constants.dart';
import 'package:hamrah/util/dbhelper.dart';
import 'package:hamrah/model/globals.dart' as globals;


BuildContext _context;

class LandingPage extends StatefulWidget {
  @override
  createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
        backgroundColor: Colors.orange,
        body: Center(
          child: RaisedButton(
              child: Text(Constants.GET_STARTED_BTN,
                  textScaleFactor: 1.5,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: isAnewUser),
        ));
  }

  void isAnewUser() {
    List<User> users = List<User>();
    DbHelper helper = DbHelper();
    helper
        .initializeDb()
        .then((result) => helper.getUsers().then((result) => users = result));

    if (!users.isEmpty) {
      navigateTo(CardsPage());
    } else {
      navigateTo(HomePage());
    }
  }

  void navigateTo(Widget page) async {
    // TODO: check whether the age entered is over 18 years.
    bool result = await Navigator.push(
        _context, MaterialPageRoute(builder: (context) => page));
  }
}
