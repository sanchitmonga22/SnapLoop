import 'package:SnapLoop/Screens/Authorization/authScreen.dart';
import 'package:flutter/material.dart';
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
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    var errorMessage = "Authenticate Failed";
    _showErrorDialog(errorMessage);
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

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      // height: 350,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
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
                    decoration: _authMode == AuthMode.Signup
                        ? InputDecoration(labelText: 'Email')
                        : InputDecoration(labelText: 'Email/Username'),
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
                    decoration: InputDecoration(labelText: 'Password'),
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
                      child: Text(
                        'Forget password?',
                        textAlign: TextAlign.start,
                      ),
                      padding: EdgeInsets.only(right: 185),
                      //TODO: Implement what forget password does
                      onPressed: () {},
                    ),

                  // Animated Container that pops from below
                  SignUpWidget(
                      authMode: _authMode,
                      opacityAnimation: opacityAnimation,
                      slideAnimation: slideAnimation,
                      passwordController: _passwordController,
                      authData: _authData),

                  // SizedBox(
                  //   height: 10,
                  // ),

                  if (_isLoading)
                    CircularProgressIndicator()
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
                      color: Theme.of(context).primaryColor,
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
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
