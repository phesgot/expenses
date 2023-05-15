import 'dart:math';
import 'package:flutter/material.dart';
import '../components/transaction_form.dart';
import '../components/transaction_list.dart';
import '../models/transaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Tênis',
      value: 310.20,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 103.75,
      date: DateTime.now(),
    ),
  ];

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(onSubmit: _addTransaction,);
      },
    );
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        appBar: AppBar(
          title: const Text("Despesas Pessoais"),
          centerTitle: false,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => _openTransactionFormModal(context),
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Card(
                elevation: 2,
                child: Text("Gráfico"),
              ),
              TransactionList(transactions: _transactions),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openTransactionFormModal(context),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

// #900c3f
// #581845
