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
                  child: Text(Constants.APP_NAME,
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          fontSize: 30.0, decoration: TextDecoration.none)),
                ),
                RaisedButton(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                    child: Text(
                      Constants.GET_STARTED_BTN,
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
