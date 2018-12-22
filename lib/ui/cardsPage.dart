import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hamrah/model/communication/dsRequest.dart';
import 'package:hamrah/model/user.dart';
import 'package:hamrah/util/constants.dart';
import 'package:http/http.dart' as http;


BuildContext _context;
const jasonCodec = const JsonCodec();

class CardsPage extends StatefulWidget{
  @override
  createState() => _CardsPage();
}

class _CardsPage extends State<CardsPage>{
  PageView _pageView = PageView();
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    _context = context;

    List<User> users = getFirst50Cards() as List<User>;

    _pageView = new PageView(children: <Widget>[
    ], controller: _pageController);

    return new Scaffold(
      backgroundColor: Colors.tealAccent,
      body: _pageView,
    );
  }

  Future<List<User>> getFirst50Cards() async {
    Uri uri = Uri.http(Constants.SERVER_URL, Constants.GET_ALL_USERS);
    DsRequest request = new DsRequest(0, 50);

    http.Response response = await http.post(
        uri,
        body: json.encode(request.toJson()),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        }
    );

    if (response.statusCode == 200) {
//      for (response.body.)
      // registration accepted: go to next page
      print(response.statusCode);
    } else {
      // user already exists: go to sign in page
      print(response.statusCode);
    }
  }
}