import 'package:SnapLoop/Provider/Auth.dart';
import 'package:SnapLoop/Widget/ErrorDialog.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

enum AuthMode { Signup, Login }

class AuthViewModel extends BaseViewModel {
  final TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;

  static const String _initialCountry = 'US';
  String get initialCountry => _initialCountry;

  PhoneNumber _number = PhoneNumber(isoCode: 'US');
  PhoneNumber get number => _number;

  final GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> get formKey => _formKey;

  AuthMode _authMode = AuthMode.Login;
  AuthMode get authMode => _authMode;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'username': '',
    'phoneNumber': '',
  };
  Map<String, String> get authData => _authData;

  var _isLoading = false; // for the Login/SignUp Button
  bool get isLoading => _isLoading;

  var _showPassword = false;
  bool get showPassword => _showPassword;

  final _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  void submit(BuildContext context) async {
    //_isLoading to false
    _isLoading = false;
    _formKey.currentState.save();
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
      }
      notifyListeners();
    } catch (error) {
      const errorMessage = "Could not authenticate you, Please try again later";
      _showErrorDialog(errorMessage, context);
    }
  }

  void _showErrorDialog(String message, BuildContext context) {
    _isLoading = false;
    notifyListeners();
    showDialog(
        context: context,
        builder: (context) => ErrorDialog(
              message: message,
            ));
  }

  void switchAuthMode(AnimationController animController) {
    if (_authMode == AuthMode.Login) {
      _authMode = AuthMode.Signup;
      animController.forward();
    } else {
      _authMode = AuthMode.Login;
      animController.reverse();
    }
    notifyListeners();
  }
}
