import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:exportapp/constants/error_handling.dart';
import 'package:exportapp/constants/global_variables.dart';
import 'package:exportapp/constants/utils.dart';
import 'package:exportapp/models/expense.dart';
import 'package:exportapp/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ExpenseReportService{
  Future<String> expenseReport({
    required BuildContext context,
    required String expenseId,
    required String expenseSum,
    required String companyName,
    required String agentName,
    required String reportSum,
    required String freeCurrencyCost,
    required String paymentOrder,
    required String bankCommission,
    required String description,
    required List<File> images,
    required int reportDate,
    required int invoice,
    required String bankName,
    required String currency,

  }) async {

    String isSuccess = "";

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {

      final cloudinary = CloudinaryPublic('zenith-service', 'b9ouvqzd');

      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: invoice.toString()),
        );
        imageUrls.add(res.secureUrl);
      }
      Expense expense = Expense(
          id: expenseId,
          userId: userProvider.user.id,
          expenseSum: expenseSum,
          companyName: companyName,
          agentName: agentName,
          bankName: bankName,
          currency: currency,
          reportSum: reportSum,
          freeCurrencyCost: freeCurrencyCost,
          paymentOrder: paymentOrder,
          bankCommission: bankCommission,
          description: description,
          images: imageUrls,
          reportDate: reportDate,
          status: 1,
      );


      http.Response res = await http.post(
        Uri.parse('$uri/update-expense'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: expense.toJson(),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          isSuccess = "success";
          showSnackBar(context, 'Отчет успешно добавлен!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return isSuccess;
  }
}