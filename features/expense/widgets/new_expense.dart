import 'package:exportapp/constants/global_variables.dart';
import 'package:exportapp/features/expense/screens/expense_report_screen.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  List list;
  NewExpense(this.list, {Key? key}) : super(key: key);

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  void navigateToExpenseReportScreen(String expenseId, int invoice,String expenseSum,int reportDate) {
    Navigator.pushNamed(context, CreateExpenseReport.routeName, arguments:
    {
      'expenseId':expenseId,
      'invoice':invoice,
      'expenseSum':expenseSum,
      'reportDate':reportDate,
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        itemBuilder: (context, index) {
          return widget.list[index].status == 0
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
              onLongPress: () => navigateToExpenseReportScreen(
                  widget.list[index].id,
                  widget.list[index].invoice,
                  widget.list[index].expenseSum,
                  widget.list[index].reportDate
              ),
            ),
          )
          :
          Container();
        });
  }
}
