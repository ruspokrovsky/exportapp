import 'package:exportapp/features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/home/screens/home_screen.dart';
import 'models/user_fb.dart';

class MiddleWares extends StatelessWidget{
  const MiddleWares({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final UserFbs? users = Provider.of<UserFbs?>(context);
    final bool isLoggedIn = users != null;
    return isLoggedIn ? const HomeScreen() : const AuthScreen();
  }
}