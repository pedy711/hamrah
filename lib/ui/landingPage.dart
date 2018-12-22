import 'package:flutter/material.dart';
import 'package:hamrah/ui/cardsPage.dart';

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
      body: Center(child: RaisedButton(onPressed: navigateToLoginPage),)
    );
  }

  void navigateToLoginPage() async {
    // TODO: check whether the age entered is over 18 years.
    bool result = await Navigator.push(
        _context, MaterialPageRoute(builder: (context) => CardsPage()));
  }
}