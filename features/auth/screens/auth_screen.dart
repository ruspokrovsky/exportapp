import 'package:exportapp/constants/global_variables.dart';
import 'package:exportapp/constants/utils.dart';
import 'package:exportapp/features/auth/services/auth_service.dart';
import 'package:exportapp/features/auth/services/user_base.dart';
import 'package:exportapp/models/user_fb.dart';
import 'package:exportapp/widgets/custom_button.dart';
import 'package:exportapp/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  UserBase dbs = UserBase();
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    String? userId;
    // authService
    //     .registerWithEmailAndPassword(
    //       _emailController.text.trim(),
    //       _passwordController.text.trim(),
    //     )
    //     .then((value) => {
    //           dbs = UserBase(),
    //           userId = value?.id,
    //           dbs.addUser(userId!, "userName", "userPhone",DateTime.now().millisecondsSinceEpoch),
    //         });

    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  void signInUser() async {
    // UserFbs? user = await authService.signInWithEmailAndPassword(
    //     _emailController.text.trim(), _passwordController.text.trim());
    // if (user == null) {
    //   showSnackBar(context, "Пользователь не найден");
    // } else {
    //   _emailController.clear();
    //   _passwordController.clear();
    // }

    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: ListTile(
              //         tileColor: GlobalVariables.backgroundColor,
              //         title: const Text("Создать аккаунт"),
              //         leading: Radio(
              //           activeColor: GlobalVariables.secondaryColor,
              //           value: Auth.signup,
              //           groupValue: _auth,
              //           onChanged: (Auth? val) {
              //             setState(() {
              //               _auth = val!;
              //             });
              //           },
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //         child: ListTile(
              //       tileColor: GlobalVariables.backgroundColor,
              //       title: const Text("Вход"),
              //       leading: Radio(
              //         activeColor: GlobalVariables.secondaryColor,
              //         value: Auth.signin,
              //         groupValue: _auth,
              //         onChanged: (Auth? val) {
              //           setState(() {
              //             _auth = val!;
              //           });
              //         },
              //       ),
              //     )),
              //   ],
              // ),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Создать аккаунт',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),

              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          textInputType: TextInputType.text,
                          hintText: 'Ваше имя',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _emailController,
                          textInputType: TextInputType.text,
                          hintText: 'Ваш Email',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _passwordController,
                          textInputType: TextInputType.text,
                          hintText: 'Пароль',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          color: GlobalVariables.secondaryColor,
                          text: 'Регистрация',
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Вход',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          textInputType: TextInputType.text,
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _passwordController,
                          textInputType: TextInputType.text,
                          hintText: 'Password',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: 'Вход',
                          color: GlobalVariables.secondaryColor,
                          onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signInUser();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
