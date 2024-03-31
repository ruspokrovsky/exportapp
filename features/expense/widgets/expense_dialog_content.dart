import 'package:exportapp/constants/global_variables.dart';
import 'package:exportapp/providers/text_field_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogContent extends StatefulWidget {
  final double sum;

  const DialogContent(this.sum, {Key? key}) : super(key: key);

  @override
  State<DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Всего в кассе: ${GlobalVariables.formatter.format(widget.sum)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                hintText: "Сумма вывода",
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black38,
                )),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black38,
                ))),
            onChanged: (text) {
              setState(() {
                context.read<TextFieldProvider>().resultString = text.trim();
              });
            }),
      ],
    );
  }
}