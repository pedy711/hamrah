import 'package:flutter/material.dart';
import 'package:hamrah/ui/cardsPage.dart';
import 'package:hamrah/util/constants.dart';

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
              onPressed: navigateToLoginPage),
        ));
  }

  void navigateToLoginPage() async {
    // TODO: check whether the age entered is over 18 years.
    bool result = await Navigator.push(
        _context, MaterialPageRoute(builder: (context) => CardsPage()));
  }
}
