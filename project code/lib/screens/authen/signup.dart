import 'package:doc_guard/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });


  @override
  State createState() => new RegisterState();
}

class RegisterState extends State<Register> with SingleTickerProviderStateMixin{
  //AnimationController _iconAnimationController;
  //Animation<double> _iconAnimation;

  /*@override
  void initState(){
    super.initState();
    _iconAnimationController = new AnimationController(
        duration: new Duration(milliseconds: 500),
        vsync: this
    );
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeOut);
    //_iconAnimation.addListener(() => this.setState((){}));
    _iconAnimationController.forward();
  }*/

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();


  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Login to Doc Guard'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/loginpage_background.jpg"),
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new FlutterLogo(
                  //size: _iconAnimation.value * 100,
                  size: 100,
                ),
                new Form(
                  key: _formKey,
                  child: Theme(
                    data: new ThemeData(
                        brightness: Brightness.dark, primarySwatch: Colors.teal,
                        inputDecorationTheme: new InputDecorationTheme(
                            labelStyle: new TextStyle(
                                color: Colors.teal, fontSize: 20.0))),
                    child: new Container(
                      padding: const EdgeInsets.all(40.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new TextFormField(
                            decoration: new InputDecoration(
                              labelText: "Enter Email",
                            ),
                            keyboardType:   TextInputType.emailAddress,
                            validator: (val) => val.isEmpty ? 'Enter an email' : null,
                            onChanged: (val){
                              setState(() => email = val);
                            },
                          ),
                          new TextFormField(
                            decoration: new InputDecoration(
                                labelText: "Enter Password"

                            ),
                            keyboardType:   TextInputType.text,
                            obscureText: true,
                            validator: (val) => val.length < 8 ? 'Enter a password  at least 8 character long' : null,
                            onChanged: (val){
                              setState(() => password = val);
                            },
                          ),
                          new Padding(
                            padding:  const EdgeInsets.only(top: 40.0),
                          ),
                          new MaterialButton(
                            height: 40.0,
                            minWidth: 100.0,
                            color: Colors.teal,
                            textColor: Colors.white,
                            child: new Text("Sign up"),
                            onPressed: () async {
                              if(_formKey.currentState.validate()){
                                dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                                if(result == null) {
                                  setState(() {
                                    error = 'Please supply a valid email';
                                  });
                                }
                              }
                            },
                            splashColor: Colors.redAccent,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          )
                        ],
                      ),
                    ),
                  ),

                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

