import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:exportapp/constants/error_handling.dart';
import 'package:exportapp/constants/global_variables.dart';
import 'package:exportapp/constants/utils.dart';
import 'package:exportapp/models/expense.dart';
import 'package:exportapp/models/invoice.dart';
import 'package:exportapp/providers/expense_provider.dart';
import 'package:exportapp/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ExpenseServices {
  Future createExpense({
    required BuildContext context,
    //required int expenseNumber,
    required String userId,
    required String expenseSum,
    required String companyName,
    required String agentName,
    required String reportSum,
    required String currency,
    required String freeCurrencyCost,
    required String paymentOrder,
    required String bankCommission,
    required String description,
    required List<File> images,
    required int reportDate,
    required int invoice,
    required status,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/create-expense'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'userId': userId,
          'expenseSum': expenseSum,
          'companyName': companyName,
          'agentName': agentName,
          'reportSum': reportSum,
          'currency': currency,
          'freeCurrencyCost': freeCurrencyCost,
          'paymentOrder': paymentOrder,
          'bankCommission': bankCommission,
          'description': description,
          'images': images,
          'reportDate': reportDate,
          'invoice': invoice,
          'status': status,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          //print("------create-expense---------------------------------res.body");
          //print(res.body);
          var expenseProvider =
              Provider.of<ExpenseProvider>(context, listen: false);
          expenseProvider.setExpense(res.body);
        },
      );
      return "success";
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Expense>> fetchAllExpense(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/get-all-expense'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var expense = context.read<ExpenseProvider>();
          expense.clearList();
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            expense.addToList(
              Expense.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return [];
  }

  Future<int> fetchActualInvoice(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Invoice> invoiceList = [];
    int? actualInvoice;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/get-all-invoice'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            invoiceList.add(
              Invoice.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }

          if (invoiceList.map((e) => e.invoice).toList().isEmpty) {
            actualInvoice = 0;
          } else {
            actualInvoice =
                invoiceList.map((e) => e.invoice).toList().reduce(max);
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return actualInvoice!;
  }
}
