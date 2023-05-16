import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    Key? key,
    required this.transactions,
    required this.onRemove,
  }) : super(key: key);

  final List<Transaction> transactions;
  final void Function(String) onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: transactions.isEmpty
          ? Column(
              children: [
                const Text("Nenhuma transação cadastrada!"),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Slidable(
                    actionExtentRatio: 0.25,
                    actionPane: const SlidableDrawerActionPane(),
                    secondaryActions: [
                      IconSlideAction(
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () => onRemove(tr.id),
                        caption: 'Deletar',
                      )
                    ],
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: FittedBox(
                              child: Text(
                                'R\$${tr.value.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          tr.title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          DateFormat('d MMM y').format(tr.date),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
