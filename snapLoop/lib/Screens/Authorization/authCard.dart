import 'package:SnapLoop/Provider/Auth.dart';
import 'package:SnapLoop/Screens/Authorization/authScreen.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:SnapLoop/Widget/ErrorDialog.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'signUpWidget.dart';

/// author: @sanchitmonga22

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
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
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
        builder: (context) => ErrorDialog(
              message: message,
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

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.zero,
      child: Card(
        elevation: 2,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: _authMode == AuthMode.Signup
                ? kMinHeightSignUp
                : kMinHeightLogin,
            curve: Curves.easeIn,
            constraints: BoxConstraints(
              minHeight: _authMode == AuthMode.Signup
                  ? kMinHeightSignUp
                  : kMinHeightLogin,
            ),
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
                    style: kTextFormFieldStyle,
                    decoration: _authMode == AuthMode.Signup
                        //Icon(CupertinoIcons.person_solid, color: Colors.white)
                        ? kgetDecoration('Email')
                        : kgetDecoration('Email/Username'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                  ),

                  // Password text field
                  TextFormField(
                    style: kTextFormFieldStyle,
                    decoration: kgetDecoration('Password'),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),

                  // Forget Password
                  if (!(_authMode == AuthMode.Signup))
                    FlatButton(
                      child: Text('Forgot password?',
                          textAlign: TextAlign.start,
                          style: kTextFormFieldStyle),
                      padding: EdgeInsets.only(right: 185),
                      onPressed: () {},
                    ),
                  SignUpWidget(
                      authMode: _authMode,
                      opacityAnimation: opacityAnimation,
                      slideAnimation: slideAnimation,
                      passwordController: _passwordController,
                      authData: _authData),

                  if (_isLoading)
                    Flex(
                      children: [CircularProgressIndicator()],
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  else
                    RaisedButton(
                      child: Text(
                        _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                        style: kTextFormFieldStyle.copyWith(
                            fontWeight: FontWeight.w900),
                      ),
                      onPressed: _submit,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      color: Colors.white10,
                      textColor: Colors.white,
                    ),
                  FlatButton(
                    child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'}',
                      style: kTextFormFieldStyle.copyWith(
                          fontWeight: FontWeight.w900),
                    ),
                    onPressed: _switchAuthMode,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textColor: Colors.white,
                    textTheme: ButtonTextTheme.primary,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
