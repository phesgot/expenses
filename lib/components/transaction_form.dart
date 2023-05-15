import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final void Function(String, double) onSubmit;

  //Controlers
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: valueController,
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      final title = titleController.text;
                      final value =
                          double.tryParse(valueController.text) ?? 0.0;
                      onSubmit(title, value);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff900c3f),
                    ),
                    child: const Text('Nova Transação'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
