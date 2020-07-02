import 'package:SnapLoop/Screens/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'authScreen.dart';

/// author: @sanchitmonga22

class SignUpWidget extends StatefulWidget {
  SignUpWidget({
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
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController controller = TextEditingController();

  String initialCountry = 'US';

  PhoneNumber number = PhoneNumber(isoCode: 'US');

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.only(top: 10),
      duration: Duration(milliseconds: 300),
      constraints: BoxConstraints(
          minHeight:
              widget._authMode == AuthMode.Signup ? kminHeightSignUpWidget : 0,
          maxHeight:
              widget._authMode == AuthMode.Signup ? kmaxHeightSignUpWidget : 0),
      curve: Curves.easeIn,
      child: FadeTransition(
        opacity: widget.opacityAnimation,
        child: SlideTransition(
          position: widget.slideAnimation,
          child: ListView(
              padding: EdgeInsets.symmetric(vertical: 5),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TextFormField(
                  cursorColor: kTextFieldCursorColor,
                  scrollPadding: EdgeInsets.all(1),
                  autovalidate: true,
                  style: kTextFormFieldStyle,
                  enabled: widget._authMode == AuthMode.Signup,
                  decoration: kgetDecoration('Confirm Password').copyWith(
                    icon: Icon(
                      CupertinoIcons.padlock_solid,
                      color: Colors.white,
                    ),
                  ),
                  obscureText: true,
                  validator: widget._authMode == AuthMode.Signup
                      ? (value) {
                          if (value != widget._passwordController.text) {
                            return 'Passwords do not match!';
                          }
                        }
                      : null,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    cursorColor: kTextFieldCursorColor,
                    style: kTextFormFieldStyle,
                    enabled: widget._authMode == AuthMode.Signup,
                    decoration: kgetDecoration('Username').copyWith(
                        icon: Icon(
                      CupertinoIcons.person_solid,
                      color: Colors.white,
                    )),
                    onSaved: (value) {
                      widget._authData['username'] = value;
                    }),
                SizedBox(
                  height: 10,
                ),
                // TODO Add an API call to check whether the username already exists or not
                // TextFormField(
                //     style: kTextFormFieldStyle,
                //     enabled: _authMode == AuthMode.Signup,
                //     decoration: kgetDecoration('Phone').copyWith(
                //         icon: Icon(
                //       CupertinoIcons.phone_solid,
                //       color: Colors.white,
                //     )),
                //     keyboardType: TextInputType.number,
                //     onSaved: (value) {
                //       _authData['phoneNumber'] = value;
                //     })
                //IMPORTANT: Modified to include the cursor color in the Phone textField
                InternationalPhoneNumberInput(
                  cursorColor: kTextFieldCursorColor,
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                  },
                  onInputValidated: (bool value) {
                    print(value);
                  },
                  ignoreBlank: false,
                  selectorTextStyle: kTextFormFieldStyle,
                  selectorType: PhoneInputSelectorType.DIALOG,
                  isEnabled: true,
                  searchBoxDecoration: kgetDecoration(""),
                  countrySelectorScrollControlled: true,
                  selectorButtonOnErrorPadding: 100,
                  textStyle: kTextFormFieldStyle,
                  // maxLength: 11,
                  initialValue: number,
                  textFieldController: controller,
                  inputBorder: OutlineInputBorder(),
                  inputDecoration: kgetDecoration("Phone").copyWith(
                      prefixIcon: Icon(
                    CupertinoIcons.phone_solid,
                    color: Colors.white,
                  )),
                ),
              ]),
        ),
      ),
    );
  }
}
