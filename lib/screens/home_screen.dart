import 'dart:ffi';
import 'dart:math';
import 'package:expenses/components/chart.dart';
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

  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Cabo',
      value: 600.20,
      date: DateTime.now().subtract(Duration(days: 33)),
    ),
    Transaction(
      id: 't1',
      title: 'Tênis',
      value: 310.20,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 103.75,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr){
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

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
              Chart(recentTransaction: _recentTransactions),
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
