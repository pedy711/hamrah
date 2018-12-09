import 'package:flutter/material.dart';
import 'package:hamrah/util/constants.dart';

class IntroductionPage extends StatefulWidget {
  @override
  createState() => _IntroductionPage();
}

class _IntroductionPage extends State<IntroductionPage> {
  PageView _pageView = PageView();
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    _pageView = new PageView(
        children: <Widget>[createAboutYourselfSlide(), createFirstNamePage()],
        controller: _pageController);

    return new Scaffold(
      backgroundColor: Colors.tealAccent,
      body: _pageView,
    );
  }

  Widget createAboutYourselfSlide() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: ListView(
            children: <Widget>[createAboutYourselfCard(), buildRaisedButton()]),
      ),
    );
  }

  Widget createFirstNamePage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 50),
            child: Text(
              Constants.ABOUT_YOU_TEXT,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textDirection: TextDirection.rtl,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 10, bottom: 50),
              child: TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(),
                      labelText: Constants.FIRST_NAME_TEXT,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))))),
          buildRaisedButton()
        ]),
      ),
    );
  }

  RaisedButton buildRaisedButton() {
    return RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
        child: Text(
          Constants.NEXT_TEXT,
          textScaleFactor: 1.5,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        textColor: Colors.white,
        color: Colors.blueAccent,
        onPressed: () {
          nextPage();
//          submit();
        });
  }

  Padding createAboutYourselfCard() {
    return Padding(
        padding: EdgeInsets.only(left: 50, right: 50, top: 5, bottom: 100),
        child: Card(
            child: Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
                child: Column(
                  children: <Widget>[
                    Text(
                      Constants.SELF_SUMMARY_TITLE_TEXT,
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      Constants.SELF_SUMMARY_TEXT,
                      textDirection: TextDirection.rtl,
                    )
                  ],
                ))));
  }

  void nextPage() {
    _pageController.nextPage(
        duration: new Duration(milliseconds: 300), curve: Curves.linear);
  }
}
