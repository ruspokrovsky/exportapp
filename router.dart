import 'package:exportapp/features/auth/screens/auth_screen.dart';
import 'package:exportapp/features/expense/screens/expense_report_screen.dart';
import 'package:exportapp/features/expense/screens/expense_screen.dart';
import 'package:exportapp/features/expense/screens/report_details_screen.dart';
import 'package:exportapp/features/home/screens/home_screen.dart';
import 'package:exportapp/features/project/screens/add_project.dart';
import 'package:exportapp/features/project/screens/create_convert_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case AddProject.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProject(),
      );
    case ProjectConvertationScreen.routeName:
      var receiptsDetails = routeSettings.arguments as Map;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProjectConvertationScreen(receiptsDetails: receiptsDetails),
      );
    case CreateExpenseReport.routeName:
      var expenseDetails = routeSettings.arguments as Map;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CreateExpenseReport(expenseDetails: expenseDetails),
      );
    case ExpenseScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ExpenseScreen(),
      );
    case ReportDetailsScreen.routeName:
      var imageList = routeSettings.arguments as List;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ReportDetailsScreen(imageList:imageList),
      );
    // case SearchScreen.routeName:
    //   var searchQuery = routeSettings.arguments as String;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => SearchScreen(
    //       searchQuery: searchQuery,
    //     ),
    //   );


    // case SearchScreen.routeName:
    //   var searchQuery = routeSettings.arguments as String;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => SearchScreen(
    //       searchQuery: searchQuery,
    //     ),
    //   );
    // case ProductDetailScreen.routeName:
    //   var product = routeSettings.arguments as Product;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => ProductDetailScreen(
    //       product: product,
    //     ),
    //   );
    // case AddressScreen.routeName:
    //   var totalAmount = routeSettings.arguments as String;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => AddressScreen(
    //       totalAmount: totalAmount,
    //     ),
    //   );
    // case OrderDetailScreen.routeName:
    //   var order = routeSettings.arguments as Order;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => OrderDetailScreen(
    //       order: order,
    //     ),
    //   );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}