import 'package:flutter/foundation.dart';

class SignUpNotifier extends ChangeNotifier{
  bool _obscureText = true;

   bool get obscureText => _obscureText;

   set obscureText(bool newState){
    _obscureText = newState;
    notifyListeners();
   }

   bool passValidator(String password){
    if(password.isEmpty) return false;
    String pattern = 
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
   }
}