import 'package:exportapp/constants/global_variables.dart';
import 'package:exportapp/features/expense/screens/report_details_screen.dart';
import 'package:exportapp/models/expense.dart';
import 'package:flutter/material.dart';

class SuccessExpense extends StatefulWidget {
  List list;
  SuccessExpense(List<Expense> this.list, {Key? key}) : super(key: key);

  @override
  State<SuccessExpense> createState() => _SuccessExpenseState();
}

class _SuccessExpenseState extends State<SuccessExpense> {

  void navigateToReportDetailsScreen(images) {
    Navigator.pushNamed(context, ReportDetailsScreen.routeName,arguments: images);
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.list.length,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        itemBuilder: (context, index) {
          return widget.list[index].status == 1
              ?
          Card(
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Аванс №:"),
                      Text('${widget.list[index].invoice}'),
                    ],
                  ),
                  const Divider(height: 0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Сумма аванса:"),
                      Text(widget.list[index].expenseSum),
                    ],
                  ),
                  const Divider(height: 0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Дата оформления:"),
                      Text(GlobalVariables.dtFormat.format(DateTime.fromMillisecondsSinceEpoch(widget.list[index].reportDate))),
                    ],
                  ),
                  Text(widget.list[index].id, textAlign: TextAlign.start,)
                ],
              ),
              onTap: () {
                navigateToReportDetailsScreen(widget.list[index].images);
              },
            ),
          )
              :
          Container();
        });
  }
}
