import 'package:flutter/material.dart';
import 'package:hamrah/model/user.dart';

//import 'package:carousel_slider/carousel_slider.dart';
import 'package:hamrah/ui/loginPage.dart';
import 'package:hamrah/util/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController signUpController = TextEditingController();
String btnText = Constants.NEXT_TEXT;
const jasonCodec = const JsonCodec();

PageController _pageController = PageController();
PageView _pageView = PageView();

class SignUpPage extends StatefulWidget {
  @override
  createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
//  CarouselSlider carouselSlider;
  String nextBtnText = Constants.NEXT_TEXT;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    _pageView = new PageView(
      children: <Widget>[createPage1(textStyle), createPage2(textStyle)],
      controller: _pageController,
    );

    return new Scaffold(
      backgroundColor: Colors.tealAccent,
      body: _pageView,
    );
  }

  RaisedButton buildRaisedButton(bool lastSlide) {
    return RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
        child: Text(
          btnText = lastSlide ? Constants.SIGN_UP : Constants.NEXT_TEXT,
          textScaleFactor: 1.5,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        textColor: Colors.white,
        color: Colors.blueAccent,
        onPressed: () {
          lastSlide ?
              registerUser().then((response) => print("Response body: " + response))
              : nextPage();
        });
  }

  void nextPage() {
    _pageController.nextPage(
        duration: new Duration(milliseconds: 300), curve: Curves.linear);
  }

  Widget createPage1(textStyle) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: ListView(children: <Widget>[
          createEmailTextField(textStyle),
          buildRaisedButton(false)
        ]),
      ),
    );
  }

  Widget createPage2(textStyle) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: ListView(children: <Widget>[
          createPasswordTextField(textStyle),
          buildRaisedButton(true)
        ]),
      ),
    );
  }

/*  Padding CustomTextField(controller, textStyle, labelText, keyboardType) {
    return Padding(
        padding: EdgeInsets.only(top: 50, bottom: 30),
        child: TextField(
          controller: controller,
          obscureText: labelText == Constants.PASSWORD_TEXT ? true : false,
          decoration: InputDecoration(
              labelText: labelText,
              labelStyle: textStyle,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0))),
          keyboardType: keyboardType,
        ));
  }*/

  Padding createEmailTextField(textStyle) {
    return Padding(
        padding: EdgeInsets.only(top: 50, bottom: 30),
        child: TextField(
          controller: emailController,
          decoration: InputDecoration(
              labelText: Constants.EMAIL_TEXT,
              labelStyle: textStyle,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0))),
          keyboardType: TextInputType.emailAddress,
        ));
  }

  Padding createPasswordTextField(textStyle) {
    return Padding(
        padding: EdgeInsets.only(top: 50, bottom: 30),
        child: TextField(
          obscureText: true,
          controller: passwordController,
          decoration: InputDecoration(
              labelText: Constants.PASSWORD_TEXT,
              labelStyle: textStyle,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0))),
          keyboardType: TextInputType.text,
        ));
  }

  Future<String> registerUser() async {
 /*   http.Response response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/todos"),
        headers: {
          "Accept": "application/json"
//          "key": "asfjkhjkhsadklflh"
        }
    );*/
    User user = new User(emailController.text, passwordController.text);
    Uri uri = Uri.http(Constants.SERVER_URL, Constants.REGISTER_USER);
    String str = json.encode(user);
    print(str);
    var body = json.encode({"foo": "bar"});

    http.Response response = await http.post(
        /*Uri.encodeFull(Constants.SERVER_URL + Constants.REGISTER_USER),*/
        uri,
//        body: {"name": "doodle", "color": "blue"},
        body: json.encode(user.toJson()),
//        body: body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        }
    );

    if (response.statusCode == 201) {
      // registration accepted: go to next page
      print(response.statusCode);
    } else {
      // user already exists: go to sign in page
      print(response.statusCode);
    }
  }
}
