import 'package:flutter/material.dart';
import 'authScreen.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({
    Key key,
    @required AuthMode authMode,
    @required this.opacityAnimation,
    @required this.slideAnimation,
    @required TextEditingController passwordController,
    @required Map<String, String> authData,
    @required this.getDecoration,
  })  : _authMode = authMode,
        _passwordController = passwordController,
        _authData = authData,
        super(key: key);

  final AuthMode _authMode;
  final Animation<double> opacityAnimation;
  final Animation<Offset> slideAnimation;
  final TextEditingController _passwordController;
  final Map<String, String> _authData;
  final Function getDecoration;
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      constraints: BoxConstraints(
          minHeight: widget._authMode == AuthMode.Signup ? 60 : 0,
          maxHeight: widget._authMode == AuthMode.Signup ? 200 : 0),
      curve: Curves.easeIn,
      child: FadeTransition(
        opacity: widget.opacityAnimation,
        child: SlideTransition(
          position: widget.slideAnimation,
          child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.white70),
                  enabled: widget._authMode == AuthMode.Signup,
                  decoration: widget.getDecoration('Confirm Password'),
                  obscureText: true,
                  validator: widget._authMode == AuthMode.Signup
                      ? (value) {
                          if (value != widget._passwordController.text) {
                            return 'Passwords do not match!';
                          }
                        }
                      : null,
                ),
                TextFormField(
                    style: TextStyle(color: Colors.white70),
                    enabled: widget._authMode == AuthMode.Signup,
                    decoration: widget.getDecoration('Username'),
                    onSaved: (value) {
                      widget._authData['username'] = value;
                    }),
                // TODO Add an API call to check whether the username already exists or not
                TextFormField(
                    style: TextStyle(color: Colors.white70),
                    enabled: widget._authMode == AuthMode.Signup,
                    decoration: widget.getDecoration('Phone'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      widget._authData['phoneNumber'] = value;
                    })
                // TODO Add a special input for taking the phone number as the input from the user and API call if the number is already taken
              ]),
        ),
      ),
    );
  }
}
