import 'package:exportapp/constants/global_variables.dart';
import 'package:exportapp/features/home/services/home_service.dart';
import 'package:exportapp/features/project/services/project_service.dart';
import 'package:exportapp/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ProjectConvertationScreen extends StatefulWidget {
  static const String routeName = '/projectConversion';
  Map<dynamic, dynamic> receiptsDetails;

  ProjectConvertationScreen({Key? key, required this.receiptsDetails}) : super(key: key);

  @override
  State<ProjectConvertationScreen> createState() =>
      _ProjectConvertationScreenState();
}

class _ProjectConvertationScreenState extends State<ProjectConvertationScreen> {

  late String projectId = "";
  late String userName = "";
  late String senderName = "";
  late String projectBank = "";
  late String currencyValue = "";
  late String projectSum = "";

  ProjectService projectService = ProjectService();
  TextEditingController conversionCostController = TextEditingController();

  double _uzs = 0.0;

  double get uzs => _uzs;

  set uzs(map) {
    _uzs = (double.parse(map['projectSum']) * double.parse(map['currencyCost']));
  }

  Future<void> _onRefresh(context) async {
    await HomeServices().fetchAllProjects(context);
    setState(() {});
  }

  void convertProject() {
    projectService.changeProjectStatus(
        context: context,
        projectId: projectId,
        projStatus: 1,
        uzsSum: uzs.toString(),
        convertCost: conversionCostController.text.trim()
    )
        .then((value) => {
      if (value == "success")
        {
          _onRefresh(context),
          setState(() {}),
          Navigator.pop(context)
        }
    });
  }

  @override
  Widget build(BuildContext context) {

    projectId = widget.receiptsDetails['_id'];
    userName = widget.receiptsDetails['userName'];
    senderName = widget.receiptsDetails['projSender'];
    projectBank = widget.receiptsDetails['projBank'];
    currencyValue = widget.receiptsDetails['currencyValue'];
    projectSum = widget.receiptsDetails['projSum'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "КОНВЕРТАЦИЯ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  GlobalVariables.dtFormat.format(DateTime.now()),
                  style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            Card(
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Отправитель:"),
                        Text(senderName),
                      ],
                    ),
                    const Divider(
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Банк:"),
                        Text(projectBank),
                      ],
                    ),
                    const Divider(
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Сумма $currencyValue:'),
                        Text(GlobalVariables.formatter
                            .format(double.parse(projectSum))),
                      ],
                    ),
                    const Divider(
                      height: 0,
                    ),
                    const Divider(
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Сумма UZS:"),
                        Text(GlobalVariables.formatter.format(uzs)),
                      ],
                    ),
                    const Divider(
                      height: 0,
                    ),
                    Text(
                      'id:$projectId',
                      style: const TextStyle(color: GlobalVariables.lightColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Expanded(
                    child: Text(
                  "Курс конвертации:",
                  style: TextStyle(
                    fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
                Expanded(
                  child: TextField(
                      controller: conversionCostController,
                      keyboardType: TextInputType.number,
                      onChanged: (String value) async {
                        uzs = {
                          'projectSum': projectSum,
                          'currencyCost': value,
                        };
                        setState(() {});
                      }),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                color: GlobalVariables.secondaryColor,
                text: "Сохранить",
                onTap: () {
                  convertProject();

                })
          ],
        ),
      ),
    );
  }
}
