import 'package:flutter/material.dart';
import 'authScreen.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({
    Key key,
    @required AuthMode authMode,
    @required this.opacityAnimation,
    @required this.slideAnimation,
    @required TextEditingController passwordController,
    @required Map<String, String> authData,
  })  : _authMode = authMode,
        _passwordController = passwordController,
        _authData = authData,
        super(key: key);

  final AuthMode _authMode;
  final Animation<double> opacityAnimation;
  final Animation<Offset> slideAnimation;
  final TextEditingController _passwordController;
  final Map<String, String> _authData;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.Signup ? 60 : 0,
          maxHeight: _authMode == AuthMode.Signup ? 200 : 0),
      curve: Curves.easeIn,
      child: FadeTransition(
        opacity: opacityAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TextFormField(
                  enabled: _authMode == AuthMode.Signup,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: _authMode == AuthMode.Signup
                      ? (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match!';
                          }
                        }
                      : null,
                ),
                TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Username'),
                    // validator: _authMode == AuthMode.Signup
                    //     ? (value) {
                    //         if (value != _passwordController.text) {
                    //           return 'Passwords do not match!';
                    //         }
                    //       }
                    //     : null,
                    onSaved: (value) {
                      _authData['username'] = value;
                    }),
                // TODO Add an API call to check whether the username already exists or not
                TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Phone'),
                    keyboardType: TextInputType.number,
                    // validator: _authMode == AuthMode.Signup
                    //     ? (value) {
                    //         if (value != _passwordController.text) {
                    //           return 'Passwords do not match!';
                    //         }
                    //       }
                    //     : null,
                    onSaved: (value) {
                      _authData['phoneNumber'] = value;
                    })
                // TODO Add a special input for taking the phone number as the input from the user and API call if the number is already taken
              ]),
        ),
      ),
    );
  }
}
