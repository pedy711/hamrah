import 'package:flutter/material.dart';
import 'package:hamrah/model/user.dart';
import 'package:hamrah/util/dbhelper.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

String emailStr = "";

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<User> users = List<User>();
    DbHelper helper = DbHelper();
    helper.initializeDb().then(
        (result) => helper.getUsers().then((result) => users=result));

    User user = User("pedram.khoshdani@gmail.com", "123");
    var result = helper.insertUser(user);

    return Center(
        child: Container(
            alignment: Alignment.center,
            color: Colors.deepPurple,
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                LogoImageWidget(),
                Row(
                  children: <Widget>[
                    Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 30.0, decoration: TextDecoration.none),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                SubmitBtnWidget(),
              ],
            )));
  }
}

class LogoImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage logoAsset = AssetImage('images/heart.png');
    Image image = Image(image: logoAsset, width: 200.0, height: 200.0);
    return Container(
      child: image,
      padding: EdgeInsets.all(50.0),
    );
  }
}

class SubmitBtnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var button = Container(
      margin: EdgeInsets.only(top: 25.0),
      child: RaisedButton(
        child: Text(
          "Login",
          textScaleFactor: 1.5,
        ),
        color: Colors.lightBlue,
        elevation: 5.0,
        onPressed: () {
          submit(context);
        },
      ),
    );

    return button;
  }

  void submit(BuildContext context) {
    var alert = AlertDialog(
      title: Text("Submitted"),
      content: Text("Thanks for visiting us"),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}

class LoginPage extends StatefulWidget {
  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return new Scaffold(
      backgroundColor: Colors.tealAccent,
        body: SingleChildScrollView(
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              LogoImageWidget(),
              Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (String string) {
                      setState(() {
                        email = string;
                      });
                    },
                  )),
              Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    keyboardType: TextInputType.text,
                    onChanged: (String string) {
                      setState(() {
                        password = string;
                      });
                    },
                  )),
              SubmitBtnWidget(),
            ],
          )),
    ));
  }
}
