import 'package:SnapLoop/ui/views/Auth/AuthViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:flutter/material.dart';

import '../../../../app/constants.dart';

class SignUpWidgetView extends HookViewModelWidget<AuthViewModel> {
  final Animation opacityAnimation;
  final Animation slideAnimation;

  SignUpWidgetView({this.opacityAnimation, this.slideAnimation});

  @override
  Widget buildViewModelWidget(BuildContext context, AuthViewModel model) {
    return AnimatedContainer(
      padding: EdgeInsets.only(top: 10),
      duration: Duration(milliseconds: 300),
      constraints: BoxConstraints(
          minHeight:
              model.authMode == AuthMode.Signup ? kminHeightSignUpWidget : 0,
          maxHeight:
              model.authMode == AuthMode.Signup ? kmaxHeightSignUpWidget : 0),
      curve: Curves.easeIn,
      child: FadeTransition(
        opacity: opacityAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: ListView(
              padding: EdgeInsets.symmetric(vertical: 5),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TextFormField(
                  cursorColor: kTextFieldCursorColor,
                  scrollPadding: EdgeInsets.all(1),
                  autovalidate: true,
                  style: kTextFormFieldStyle,
                  enabled: model.authMode == AuthMode.Signup,
                  decoration: kgetDecoration('Confirm Password').copyWith(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                  ),
                  obscureText: true,
                  validator: model.authMode == AuthMode.Signup
                      ? (value) {
                          if (value != model.passwordController.text) {
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
                    enabled: model.authMode == AuthMode.Signup,
                    decoration: kgetDecoration('Username').copyWith(
                        icon: Icon(
                      CupertinoIcons.person_solid,
                      color: Colors.white,
                    )),
                    onSaved: (value) {
                      model.authData['username'] = value;
                    }),
                SizedBox(
                  height: 10,
                ),
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
                    model.authData['phoneNumber'] = number.toString();
                  },
                  onInputValidated: (bool value) {},
                  ignoreBlank: false,
                  selectorTextStyle: kTextFormFieldStyle,
                  selectorType: PhoneInputSelectorType.DIALOG,
                  isEnabled: true,
                  searchBoxDecoration: kgetDecoration(""),
                  countrySelectorScrollControlled: true,
                  selectorButtonOnErrorPadding: 100,
                  textStyle: kTextFormFieldStyle,
                  // maxLength: 11,
                  initialValue: model.number,
                  textFieldController: model.controller,
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
