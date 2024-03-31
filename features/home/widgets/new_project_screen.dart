import 'dart:convert';

import 'package:exportapp/constants/global_variables.dart';
import 'package:exportapp/features/project/screens/create_convert_screen.dart';
import 'package:exportapp/models/project.dart';
import 'package:flutter/material.dart';

class NewProject extends StatefulWidget {
  final List projects;
  NewProject(List<Project> this.projects,{Key? key}) : super(key: key);

  @override
  State<NewProject> createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {

  void navigateToProjectConversionScreen(map) {
    Navigator.pushNamed(context, ProjectConvertationScreen.routeName, arguments: map);
  }
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      //reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        itemCount: widget.projects.length,
        itemBuilder: (context, index) {
          return widget.projects[index].projStatus == 0
          ?
          Card(
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Отправитель:"),
                      Text(widget.projects[index].projSender),
                    ],
                  ),
                  const Divider(height: 0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Банк:"),
                      Text(widget.projects[index].projBank),
                    ],
                  ),
                  const Divider(height: 0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Валюта:'),
                      Text(widget.projects[index].currencyValue),
                    ],
                  ),
                  const Divider(height: 0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Сумма:"),
                      Text(GlobalVariables.formatter.format(double.parse(widget.projects[index].projSum))),
                    ],
                  ),
                  const Divider(height: 0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Комиссия:"),
                      Text('${widget.projects[index].projCommission} %'),
                    ],
                  ),
                  const Divider(height: 0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Всего:"),
                      Text(GlobalVariables.formatter.format(double.parse(widget.projects[index].projAmount))),
                    ],
                  ),
                  const Divider(height: 0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Дата транзакции:"),
                      Text(GlobalVariables.dtFormat.format(DateTime.fromMillisecondsSinceEpoch(widget.projects[index].projDate))),
                    ],
                  ),
                  Text('id:${widget.projects[index].id}', style: const TextStyle(color: GlobalVariables.lightColor),),
                ],
              ),
              onLongPress: (){

                 navigateToProjectConversionScreen({
                   "_id": widget.projects[index].id,
                   "userId": widget.projects[index].userId,
                   "userName": widget.projects[index].userName,
                   "projSender": widget.projects[index].projSender,
                   "projDate": widget.projects[index].projDate,
                   "projBank": widget.projects[index].projBank,
                   "projSum": widget.projects[index].projSum,
                   "projCommission": widget.projects[index].projCommission,
                   "projAmount": widget.projects[index].projAmount,
                   "currencyValue": widget.projects[index].currencyValue,
                   "projDebtRepayment": widget.projects[index].projDebtRepayment,
                   "projBalance": widget.projects[index].projBalance,
                   "projStatus": widget.projects[index].projStatus,
                 });
              },
            ),
          )
          :
          Container();
        });
  }
}
