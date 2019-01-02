import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hamrah/ui/landingPage.dart';
import 'package:hamrah/util/constants.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';

BuildContext _context;

class IntroductionPage extends StatefulWidget {
  @override
  createState() => _IntroductionPage();
}

class _IntroductionPage extends State<IntroductionPage> {
  PageView _pageView = PageView();
  PageController _pageController = PageController();
  TextEditingController firstNameController = TextEditingController();
  bool _firstNameBtnActivated = false;
  int _genderSelection = -1;
  final dateFormat = intl.DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  DateTime date;
  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;
  StreamSubscription<Map<String, double>> _locationSubscription;
  Location _location = new Location();
  bool _permission = false;
  String error;
  String _country;

  @override
  void initState() {
    super.initState();

//    initPlatformState();

/*    _locationSubscription =
        _location.onLocationChanged().listen((Map<String,double> result) {
          setState(() {
            _currentLocation = result;
            print(result);
          });
        });*/
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    _pageView = new PageView(children: <Widget>[
      createAboutYourselfSlide(),
      createFirstNamePage(),
      createGenderPage(),
      createBirthdayPage(),
      createLocationPage(),
    ], controller: _pageController);

    return new Scaffold(
      backgroundColor: Colors.tealAccent,
      body: _pageView,
    );
  }

  // ------------------------------------------[ About You Page]------------------------------------------------
  Widget createAboutYourselfSlide() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: ListView(
            children: <Widget>[createAboutYourselfCard(), buildRaisedButton()]),
      ),
    );
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

  RaisedButton buildRaisedButton() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Text(
        Constants.NEXT_TEXT,
        textScaleFactor: 1.5,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      textColor: Colors.white,
      color: Colors.blueAccent,
      onPressed: () => nextPage(),
//          submit();
    );
  }

  // ------------------------------------------[ First name Page]------------------------------------------------
  Widget createFirstNamePage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: ListView(children: <Widget>[
          createFirstNameFields(),
          Padding(padding: EdgeInsets.only(bottom: 145)),
          buildRaisedButtonForFirstNamePage()
        ]),
      ),
    );
  }

  Column createFirstNameFields() {
    return Column(
      children: <Widget>[
        Text(
          Constants.ABOUT_YOU_TEXT,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textDirection: TextDirection.rtl,
        ),
        TextField(
            maxLength: 50,
            controller: firstNameController,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
                hintStyle: TextStyle(),
                labelText: Constants.FIRST_NAME_TEXT,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            onChanged: onTextChanged),
      ],
    );
  }

  void onTextChanged(String value) {
    setState(() {
      if (value.isNotEmpty && value.length > 1)
        _firstNameBtnActivated = true;
      else
        _firstNameBtnActivated = false;
    });
  }

  RaisedButton buildRaisedButtonForFirstNamePage() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Text(
        Constants.NEXT_TEXT,
        textScaleFactor: 1.5,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      textColor: Colors.white,
      color: Colors.blueAccent,
      onPressed: _firstNameBtnActivated ? () => nextPage() : null,
//          submit();
    );
  }

  void nextPage() {
    _pageController.nextPage(
        duration: new Duration(milliseconds: 300), curve: Curves.linear);
  }

  // ------------------------------------------[ Gender Page]------------------------------------------------
  Widget createGenderPage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: ListView(children: <Widget>[
          createGenderSelectionCard(),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          buildRaisedButtonForGenderPage()
        ]),
      ),
    );
  }

  Column createGenderSelectionCard() {
    return Column(
      children: <Widget>[
        Text(
          Constants.ABOUT_YOU_TEXT,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textDirection: TextDirection.rtl,
        ),
        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 50),
            child: Card(
              child: Column(
                children: createRadios(),
              ),
            ))
      ],
    );
  }

  List<Widget> createRadios() {
    List<Widget> list = new List<Widget>();

    list.add(new Column(
      children: <Widget>[
        new RadioListTile(
            value: 0,
            groupValue: _genderSelection,
            title: Text(Constants.FEMALE),
            onChanged: (int value) {
              onChangedRadio(value);
            }),
        new Divider(),
        new RadioListTile(
            value: 1,
            groupValue: _genderSelection,
            title: Text(Constants.MALE),
            onChanged: (int value) {
              onChangedRadio(value);
            }),
      ],
    ));

    return list;
  }

  void onChangedRadio(int value) {
    setState(() {
      _genderSelection = value;
      _genderPageBtnActivated = true;
    });
  }

  bool _genderPageBtnActivated = false;

  RaisedButton buildRaisedButtonForGenderPage() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Text(
        Constants.NEXT_TEXT,
        textScaleFactor: 1.5,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      textColor: Colors.white,
      color: Colors.blueAccent,
      onPressed: _genderPageBtnActivated ? () => nextPage() : null,
//          submit();
    );
  }

  // ------------------------------------------[ Birthday Page]------------------------------------------------
  bool _birthdayPageBtnActivated = false;

  Widget createBirthdayPage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: ListView(children: <Widget>[
          createBirthdayDatePicker(),
          Padding(padding: EdgeInsets.only(bottom: 113)),
          buildRaisedButtonForBirthdayPage()
        ]),
      ),
    );
  }

  Column createBirthdayDatePicker() {
    return Column(
      children: <Widget>[
        Text(
          Constants.BIRTHDAY,
          textDirection: TextDirection.rtl,
          textScaleFactor: 1.5,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 50),
          child: RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            onPressed: _showDatePicker,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '$_datetime',
                    textScaleFactor: 1.5,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.date_range,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            textColor: Colors.white,
            color: Colors.blue,
          ),
        )
      ],
    );
  }

  String _datetime = '';
  int _year = 2018;
  int _month = 11;
  int _date = 11;

  /// Display date picker.
  void _showDatePicker() {
    String _lang = 'en';
    String _format = 'yyyy-mm-dd';
    bool _showTitleActions = true;

    final bool showTitleActions = false;
    DatePicker.showDatePicker(
      context,
      showTitleActions: _showTitleActions,
      minYear: 1300,
      maxYear: 1397,
      initialYear: _year,
      initialMonth: _month,
      initialDate: _date,
      confirm: Text(
        Constants.OK,
        style: TextStyle(color: Colors.green),
      ),
      cancel: Text(
        Constants.CANCEL,
        style: TextStyle(color: Colors.red),
      ),
      locale: _lang,
      dateFormat: _format,
      onChanged: (year, month, date) {
        debugPrint('onChanged date: $year-$month-$date');

        if (!showTitleActions) {
          _changeDatetime(year, month, date);
        }
      },
      onConfirm: (year, month, date) {
        _changeDatetime(year, month, date);
        _birthdayPageBtnActivated = true;
      },
    );
  }

  void _changeDatetime(int year, int month, int date) {
    setState(() {
      _year = year;
      _month = month;
      _date = date;
      _datetime = '$year-$month-$date';
    });
  }

  RaisedButton buildRaisedButtonForBirthdayPage() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Text(
        Constants.NEXT_TEXT,
        textScaleFactor: 1.5,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      textColor: Colors.white,
      color: Colors.blueAccent,
      onPressed:
          _birthdayPageBtnActivated ? () => navigateToLandingPage() : null,
//          submit();
    );
  }

  void navigateToLandingPage() async {
    bool result = await Navigator.push(
        _context, MaterialPageRoute(builder: (context) => LandingPage()));
  }

// ------------------------------------------[ Location Page]------------------------------------------------
  bool _locationPageBtnActivated = false;
  bool _defaultLocationCard = true;

  Widget createLocationPage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: ListView(children: <Widget>[
          Text(
            Constants.ABOUT_YOU_TEXT,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textDirection: TextDirection.rtl,
          ),
          Text(
            Constants.WHERE_DO_YOU_LIVE,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textDirection: TextDirection.rtl,
          ),
          _defaultLocationCard ? createLocationCard() : createLocationForm(),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          buildRaisedButtonLocationNextPage()
        ]),
      ),
    );
  }

  Column createLocationCard() {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 40, bottom: 50),
            child: Card(
                child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Text(
                    Constants.AUTOMATIC_LOCATION,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                  Padding(padding: EdgeInsets.all(30)),
                  enableLocationServicesBtn(),
                  Padding(padding: EdgeInsets.all(5)),
                  InkWell(
                    child: Text(
                      "No Thanks",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () => setState(() {
                      _defaultLocationCard = false;
                      _locationPageBtnActivated = true;
                    }),
                  )
                ],
              ),
            )))
      ],
    );
  }

  Widget createLocationForm() {
    return CountryCodePicker(
      onChanged: (countryCode) => _onCountryChange(countryCode),
      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
      initialSelection: 'IR',
      favorite: ['+98','IR'],
    );
  }

  _onCountryChange(CountryCode countryCode) {
    _country = countryCode.name;
  /*  setState(() {
      _locationPageBtnActivated = true;
    });*/
    print("New Country selected: " + countryCode.toString());
  }

  RaisedButton buildRaisedButtonLocationNextPage() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(2.0)),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Text(
        Constants.NEXT_TEXT,
        textScaleFactor: 1.5,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      textColor: Colors.white,
      color: Colors.blueAccent,
      onPressed: _locationPageBtnActivated ? () => nextPage() : null,
//          submit();
    );
  }

  RaisedButton enableLocationServicesBtn() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(2.0)),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Padding(
        padding: EdgeInsets.only(left: 80, right: 80),
        child: Text(
          Constants.ACTIVATE,
          textScaleFactor: 1.2,
        ),
      ),
      textColor: Colors.white,
      color: Colors.blueAccent,
      onPressed: () => initPlatformState(),
//          submit();
    );
  }

  initPlatformState() async {
    Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.
/**/
    try {
      _permission = await _location.hasPermission();
      location = await _location.getLocation();
      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    //if (!mounted) return;

    setState(() {
      _startLocation = location;
    });

    _locationSubscription =
        _location.onLocationChanged().listen((Map<String, double> result) {
      setState(() {
        _locationPageBtnActivated = true;
        _currentLocation = result;
      });
    });
  }
}
