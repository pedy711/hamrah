import 'package:flutter/material.dart';
import 'package:hamrah/ui/loginPage.dart';
import 'package:hamrah/util/constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            alignment: Alignment.center,
            color: Colors.tealAccent,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 300.0, bottom: 100.0),
                  child: Text(Constants.APP_NAME_PERSIAN,
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          fontSize: 30.0, decoration: TextDecoration.none)),
                ),
                RaisedButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                    child: Text(
                      Constants.BECOME_A_MEMBER,
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    onPressed: () => navigateToLoginPage(context)),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                ),
                RaisedButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                    child: Text(
                      Constants.ALREADY_A_MEMBER_TEXT,
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    onPressed: () => navigateToLoginPage(context)),
              ],
            )));
  }

  void navigateToLoginPage(BuildContext context) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
