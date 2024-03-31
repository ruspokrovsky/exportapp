import 'package:exportapp/constants/global_variables.dart';
import 'package:exportapp/features/auth/services/auth_service.dart';
import 'package:exportapp/models/user_fb.dart';
import 'package:exportapp/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'middleWares.dart';
import 'providers/expense_provider.dart';
import 'providers/project_provider.dart';
import 'providers/receipts_provider.dart';
import 'providers/text_field_provider.dart';
import 'providers/user_provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProjectProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ExpenseProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => TextFieldProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ReceiptsProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserFbs?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Export App',
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          useMaterial3: true, // can remove this line
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: const MiddleWares(),


        // home: Provider.of<UserProvider>(context).user.token.isNotEmpty
        //         ? const HomeScreen()
        //         : const AuthScreen(),
      ),
    );
  }
}
