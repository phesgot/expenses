import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final void Function(String, double) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  //Controlers
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm(){
      final title = titleController.text;
      final value = double.tryParse(valueController.text) ?? 0.0;

      if(title.isEmpty || value <= 0){
        return;
      }
      widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: valueController,
              onSubmitted: (_) => _submitForm(),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff581845),
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
