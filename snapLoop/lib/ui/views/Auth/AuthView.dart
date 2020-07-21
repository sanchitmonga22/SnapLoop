import 'package:SnapLoop/Widget/AnimatingFlatButton.dart';
import 'package:SnapLoop/ui/views/Auth/AuthViewModel.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked/stacked.dart';
import '../../../constants.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
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

  Widget getButton(model) {
    return FlatButton(
      child: Text(
        model.authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
        style: kTextFormFieldStyle.copyWith(fontWeight: FontWeight.w900),
      ),
      onPressed: () => model.submit(context),
      shape: model.isLoading
          ? null
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
      padding: model.isLoading
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
      color: model.isLoading ? Colors.transparent : Colors.black38,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceData = MediaQuery.of(context);
    final deviceSize = deviceData.size;
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => AuthViewModel(),
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      height: deviceSize.height,
                      width: deviceSize.width,
                      decoration: kHomeScreenDecoration,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                bottom: 25, left: 10, right: 10, top: 10),
                            child: ColorizeAnimatedTextKit(
                              text: ["Snap∞Loop"],
                              textStyle: kLOGOTextStyle,
                              speed: Duration(milliseconds: 1000),
                              //isRepeatingAnimation: true,
                              colors: [
                                // Colors.purple,
                                Colors.white70,
                                Colors.yellow,
                                Colors.blueGrey,
                                CupertinoColors.activeOrange
                              ],
                              textAlign: TextAlign.center,
                              repeatForever: true,
                            ),
                          ),
                          Container(
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
                                  height: model.authMode == AuthMode.Signup
                                      ? kMinHeightSignUp
                                      : kMinHeightLogin,
                                  curve: Curves.easeIn,
                                  constraints: BoxConstraints(
                                    minHeight: model.authMode == AuthMode.Signup
                                        ? kMinHeightSignUp
                                        : kMinHeightLogin,
                                  ),
                                  width: deviceSize.width * 0.85,
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 4),
                                  child: Form(
                                    key: model.formKey,
                                    // The form components
                                    child: ListView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: <Widget>[
                                        // Email Text Field
                                        TextFormField(
                                          cursorColor: kTextFieldCursorColor,
                                          autofocus: false,
                                          style: kTextFormFieldStyle,
                                          decoration: model.authMode ==
                                                  AuthMode.Signup
                                              ? kgetDecoration('Email')
                                                  .copyWith(
                                                  icon: Icon(
                                                    CupertinoIcons.mail_solid,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : kgetDecoration('Email/Username')
                                                  .copyWith(
                                                  icon: Icon(
                                                    CupertinoIcons.person_solid,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (value) {
                                            if (value.isEmpty ||
                                                !value.contains('@')) {
                                              return 'Invalid email!';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            model.authData['email'] = value;
                                          },
                                        ),

                                        // Password text field
                                        TextFormField(
                                          cursorColor: kTextFieldCursorColor,
                                          style: kTextFormFieldStyle,
                                          decoration: kgetDecoration('Password')
                                              .copyWith(
                                            icon: Icon(
                                              Icons.lock,
                                              color: Colors.white,
                                            ),
                                            suffix: GestureDetector(
                                              child: model.showPassword
                                                  ? Icon(
                                                      Icons.visibility,
                                                      color: Colors.white,
                                                    )
                                                  : Icon(
                                                      Icons.visibility_off,
                                                      color: Colors.white,
                                                    ),
                                              onTap: () {
                                                setState(() {
                                                  model.showPassword =
                                                      !model.showPassword;
                                                });
                                              },
                                            ),
                                          ),
                                          obscureText:
                                              model.showPassword ? false : true,
                                          controller: model.passwordController,
                                          validator: (value) {
                                            if (value.isEmpty ||
                                                value.length < 5) {
                                              return 'Password is too short!';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            model.authData['password'] = value;
                                          },
                                        ),
                                        AnimatedContainer(
                                          padding: EdgeInsets.only(top: 10),
                                          duration: Duration(milliseconds: 300),
                                          constraints: BoxConstraints(
                                              minHeight: model.authMode ==
                                                      AuthMode.Signup
                                                  ? kminHeightSignUpWidget
                                                  : 0,
                                              maxHeight: model.authMode ==
                                                      AuthMode.Signup
                                                  ? kmaxHeightSignUpWidget
                                                  : 0),
                                          curve: Curves.easeIn,
                                          child: FadeTransition(
                                            opacity: opacityAnimation,
                                            child: SlideTransition(
                                              position: slideAnimation,
                                              child: ListView(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  children: [
                                                    TextFormField(
                                                      cursorColor:
                                                          kTextFieldCursorColor,
                                                      scrollPadding:
                                                          EdgeInsets.all(1),
                                                      autovalidate: true,
                                                      style:
                                                          kTextFormFieldStyle,
                                                      enabled: model.authMode ==
                                                          AuthMode.Signup,
                                                      decoration: kgetDecoration(
                                                              'Confirm Password')
                                                          .copyWith(
                                                        icon: Icon(
                                                          Icons.lock,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      obscureText: true,
                                                      validator: model
                                                                  .authMode ==
                                                              AuthMode.Signup
                                                          ? (value) {
                                                              if (value !=
                                                                  model
                                                                      .passwordController
                                                                      .text) {
                                                                return 'Passwords do not match!';
                                                              }
                                                            }
                                                          : null,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                        cursorColor:
                                                            kTextFieldCursorColor,
                                                        style:
                                                            kTextFormFieldStyle,
                                                        enabled:
                                                            model.authMode ==
                                                                AuthMode.Signup,
                                                        decoration:
                                                            kgetDecoration(
                                                                    'Username')
                                                                .copyWith(
                                                                    icon: Icon(
                                                          CupertinoIcons
                                                              .person_solid,
                                                          color: Colors.white,
                                                        )),
                                                        onSaved: (value) {
                                                          model.authData[
                                                                  'username'] =
                                                              value;
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
                                                      cursorColor:
                                                          kTextFieldCursorColor,
                                                      onInputChanged:
                                                          (PhoneNumber number) {
                                                        model.authData[
                                                                'phoneNumber'] =
                                                            number.toString();
                                                      },
                                                      onInputValidated:
                                                          (bool value) {},
                                                      ignoreBlank: false,
                                                      selectorTextStyle:
                                                          kTextFormFieldStyle,
                                                      selectorType:
                                                          PhoneInputSelectorType
                                                              .DIALOG,
                                                      isEnabled: true,
                                                      searchBoxDecoration:
                                                          kgetDecoration(""),
                                                      countrySelectorScrollControlled:
                                                          true,
                                                      selectorButtonOnErrorPadding:
                                                          100,
                                                      textStyle:
                                                          kTextFormFieldStyle,
                                                      // maxLength: 11,
                                                      initialValue:
                                                          model.number,
                                                      textFieldController:
                                                          model.controller,
                                                      inputBorder:
                                                          OutlineInputBorder(),
                                                      inputDecoration:
                                                          kgetDecoration(
                                                                  "Phone")
                                                              .copyWith(
                                                                  prefixIcon:
                                                                      Icon(
                                                        CupertinoIcons
                                                            .phone_solid,
                                                        color: Colors.white,
                                                      )),
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ),

                                        // Forget Password
                                        if (!(model.authMode ==
                                            AuthMode.Signup))
                                          FlatButton(
                                            child: Text('Forgot password?',
                                                textAlign: TextAlign.start,
                                                style: kTextFormFieldStyle),
                                            padding:
                                                EdgeInsets.only(right: 185),
                                            onPressed: () {},
                                          ),

                                        if (model.isLoading)
                                          AnimatingFlatButton(
                                            isAnimating: model.isLoading,
                                            labelText:
                                                model.authMode == AuthMode.Login
                                                    ? 'LOGIN'
                                                    : 'SIGN UP',
                                            onClicked: () {},
                                          )
                                        else
                                          getButton(model),
                                        FlatButton(
                                          child: Text(
                                            '${model.authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'}',
                                            style: kTextFormFieldStyle.copyWith(
                                                fontWeight: FontWeight.w900),
                                          ),
                                          onPressed: () =>
                                              model.switchAuthMode(_controller),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          textColor: Colors.white,
                                          textTheme: ButtonTextTheme.primary,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
