import 'package:exportapp/constants/global_variables.dart';
import 'package:exportapp/features/project/screens/create_convert_screen.dart';
import 'package:exportapp/models/project.dart';
import 'package:flutter/material.dart';

class SuccessProjectScreen extends StatefulWidget {
  final List projects;
  const SuccessProjectScreen(List<Project> this.projects, {Key? key}) : super(key: key);

  @override
  State<SuccessProjectScreen> createState() => _SuccessProjectScreenState();
}

class _SuccessProjectScreenState extends State<SuccessProjectScreen> {
  void navigateToProjectConversionScreen(projects) {
    Navigator.pushNamed(context, ProjectConvertationScreen.routeName,
        arguments: projects);
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        itemCount: widget.projects.length,
        itemBuilder: (context, index) {
          return widget.projects[index].projStatus == 2
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
                      const Text("Сумма:"),
                      Text('${GlobalVariables.formatter.format(double.parse(widget.projects[index].projSum))} ${widget.projects[index].currencyValue}'),
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
                      Text('${GlobalVariables.formatter.format(double.parse(widget.projects[index].projAmount))} ${widget.projects[index].currencyValue}'),
                    ],
                  ),
                  const Divider(height: 0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Погашение"),
                      Text('${GlobalVariables.formatter.format(double.parse(widget.projects[index].projDebtRepayment))} ${widget.projects[index].currencyValue}'),
                    ],
                  ),
                  const Divider(height: 0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Остаток:"),
                      Text('${GlobalVariables.formatter.format(double.parse(widget.projects[index].projBalance))} ${widget.projects[index].currencyValue}'),
                    ],
                  ),
                  const Divider(height: 0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Статус:"),
                      Text('${widget.projects[index].projStatus}'),
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
              onTap: (){

                navigateToProjectConversionScreen(widget.projects[index]);

              },
            ),
          )
          :
          Container();
        });
  }
}
