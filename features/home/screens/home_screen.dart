import 'dart:convert';

import 'package:exportapp/constants/global_variables.dart';
import 'package:exportapp/features/auth/services/auth_service.dart';
import 'package:exportapp/features/expense/screens/expense_report_screen.dart';
import 'package:exportapp/features/expense/screens/expense_screen.dart';
import 'package:exportapp/features/expense/services/expense_service.dart';
import 'package:exportapp/features/home/services/home_service.dart';
import 'package:exportapp/features/home/widgets/convet_project_screen.dart';
import 'package:exportapp/features/home/widgets/new_project_screen.dart';
import 'package:exportapp/features/home/widgets/success_project.dart';
import 'package:exportapp/features/project/screens/add_project.dart';
import 'package:exportapp/models/expense.dart';
import 'package:exportapp/models/project.dart';
import 'package:exportapp/providers/expense_provider.dart';
import 'package:exportapp/providers/receipts_provider.dart';
import 'package:exportapp/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Project>? projects;
  List<Expense>? expense;

  @override
  void initState() {
    super.initState();
    fetchAllProjects();
    fetchAllExpense();
  }

  Future fetchAllProjects() async {
    await HomeServices().fetchAllProjects(context);
    setState(() {});
  }

  fetchAllExpense() async {
    await ExpenseServices().fetchAllExpense(context);
    setState(() {});
  }

  Future<void> _onRefresh() async {
    await HomeServices().fetchAllProjects(context);
    fetchAllExpense();
    setState(() {});
    return Future<void>.delayed(const Duration(seconds: 0));
  }

  void navigateToCreateExpenseScreen() {
    Navigator.pushNamed(context, CreateExpenseReport.routeName);
  }

  void _details(){
    var receipts = context.watch<ReceiptsProvider>();
    setState((){
      projects  = receipts.project;
    });

    var expenseFromProvider = context.watch<ExpenseProvider>();
    setState((){
      expense  = expenseFromProvider.expense;
    });
  }

  @override
  Widget build(BuildContext context) {

    print("-----------context.watch<UserFbs>().id---------");
    //print(context.watch<UserFbs>().id);

    _details();

    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0
            ? const Text(
                "ПОСТУПЛЕНИЯ",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : _selectedIndex == 1
                ? const Text(
                    "КОНВЕРТИРОВАННЫЕ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                : _selectedIndex == 2
                    ? const Text(
                        "ЗАКРЫТЫЕ ПРОЕКТЫ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : Container(),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
              // Callback that sets the selected popup menu item.
              onSelected: (item) {
                if (item == 0) {
                  Navigator.pushNamed(context, AddProject.routeName);
                } else if (item == 1) {
                  Navigator.pushNamed(context, ExpenseScreen.routeName);
                } else if (item == 2) {
                  //AuthService().logOut();

                  HomeServices().logOut(context);
                }
              },
              itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: 0,
                      child: Text('Создать проект'),
                    ),
                    const PopupMenuItem(
                      value: 1,
                      child: Text('Авансы'),
                    ),
                    const PopupMenuItem(
                      value: 2,
                      child: Text('Выход'),
                    ),
                  ])
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: projects == null
            ? const Loader()
            : _selectedIndex == 0
                ? NewProject(projects!)
                : _selectedIndex == 1
                    ? ConversionProjectScreen(projects!, expense!)
                    : _selectedIndex == 2
                        ? SuccessProjectScreen(projects!)
                        : Container(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outline_blank),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
