import 'package:SnapLoop/Provider/Auth.dart';
import 'package:SnapLoop/Screens/Authorization/authScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'signUpWidget.dart';

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Initially it is login
  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'username': '',
    'phoneNumber': '',
  };

  var _isLoading = false; // for the Login/SignUp Button

  final _passwordController = TextEditingController();

  AnimationController _controller;
  Animation<Offset> slideAnimation;
  Animation<double> opacityAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
    slideAnimation = Tween<Offset>(begin: Offset(0, -1.5), end: Offset(0, 0))
        .animate(
            CurvedAnimation(curve: Curves.fastOutSlowIn, parent: _controller));
    opacityAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(curve: Curves.easeIn, parent: _controller));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("An error occured"),
              content: Text(message),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("okay"))
              ],
            ));
  }

  void _submit() async {
    //Navigator.of(context).pushNamed(HomeScreen.routeName);
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .attemptLogIn(_authData['email'], _authData['password']);
      } else {
        await Provider.of<Auth>(context, listen: false).attemptSignUp(
            _authData['username'],
            _authData['password'],
            _authData["phoneNumber"],
            _authData["email"]);
        print(_authData);
        print('Attempting signUp');
      }
    } catch (error) {
      const errorMessage = "Could not authenticate you, Please try again later";
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  // Switching between signUp/ Login
  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  //TODO use this for our email
  String _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return 'Email is not valid';
  }

  InputDecoration getDecoration(String text) {
    return InputDecoration(
        labelText: text,
        labelStyle: TextStyle(color: Colors.white70),
        focusColor: Colors.white70,
        errorStyle:
            TextStyle(color: Colors.white70, fontWeight: FontWeight.bold));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      // height: 350,
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        //elevation: 8.0,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: _authMode == AuthMode.Signup ? 700 : 280,
            curve: Curves.easeIn,
            //height: _heightAnimation.value.height,
            constraints: BoxConstraints(
                minHeight: _authMode == AuthMode.Signup ? 320 : 330),
            width: deviceSize.width * 0.85,
            padding: EdgeInsets.only(left: 16, right: 16, top: 4),
            child: Form(
              key: _formKey,

              // The form components
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  // Email Text Field
                  TextFormField(
                    style: TextStyle(color: Colors.white70),
                    decoration: _authMode == AuthMode.Signup
                        ? getDecoration('Email')
                        : getDecoration('Email/Username'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      //TODO: Add a regex for valid email
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                  ),

                  // Password text field
                  TextFormField(
                    style: TextStyle(color: Colors.white70),
                    decoration: getDecoration('Password'),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                    // TODO: Add a regex to check the password satisfies the standards and display the strength of the password when signing up
                  ),

                  // Forget Password
                  if (!(_authMode == AuthMode.Signup))
                    FlatButton(
                      child: Text('Forget password?',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white70)),
                      padding: EdgeInsets.only(right: 185),
                      //TODO: Implement what forget password does
                      onPressed: () {},
                    ),

                  // Animated Container that pops from below
                  SignUpWidget(
                      getDecoration: getDecoration,
                      authMode: _authMode,
                      opacityAnimation: opacityAnimation,
                      slideAnimation: slideAnimation,
                      passwordController: _passwordController,
                      authData: _authData),
                  SizedBox(
                    height: 10,
                  ),
                  if (_isLoading)
                    Flex(
                      children: [CircularProgressIndicator()],
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  else
                    RaisedButton(
                      child: Text(
                          _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                      onPressed: _submit,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      color: Color.fromRGBO(74, 20, 140, 0.9),
                      textColor:
                          Theme.of(context).primaryTextTheme.button.color,
                    ),
                  FlatButton(
                      child: Text(
                          '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'}'),
                      onPressed: _switchAuthMode,
                      // padding:
                      //     EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textColor: Theme.of(context).textTheme.button.color),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
