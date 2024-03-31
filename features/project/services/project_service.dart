import 'dart:convert';
import 'package:exportapp/constants/error_handling.dart';
import 'package:exportapp/constants/global_variables.dart';
import 'package:exportapp/constants/utils.dart';
import 'package:exportapp/providers/project_provider.dart';
import 'package:exportapp/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProjectService {
  Future<String> addProject({
    required BuildContext context,
    required List<Map<String, dynamic>> projectArray,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String isSuccess = "";
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-project'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'projectArray': projectArray,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          isSuccess = "success";
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return isSuccess;
  }

  Future<String> changeProjectStatus({
    required BuildContext context,
    required String projectId,
    required int projStatus,
    required String uzsSum,
    required String convertCost,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String isSuccess = "";
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/change-project-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'projectId': projectId,
          'projStatus': projStatus,
          'projUzsSum': uzsSum,
          'convertCost': convertCost,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          isSuccess = "success";
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return isSuccess;
  }

  Future addRepayment({
    required BuildContext context,
    required String projectId,
    required String debtRepayment,
    required String projBalance,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/add-repayment'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'projectId': projectId,
          'debtRepayment': debtRepayment,
          'projBalance': projBalance,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
      return "success";
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
