import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:expenses/components/chart.dart';
import 'package:flutter/cupertino.dart';
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
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(
          onSubmit: _addTransaction,
        );
      },
    );
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context);

    // vrificar a orientação do aparelho.
    bool isLandscape = mediaQuerry.orientation == Orientation.landscape;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
          _showChart ? Icons.list : Icons.bar_chart,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      )
    ];

    final appBar = AppBar(
      title: Text(
        "Despesas Pessoais",
        style: TextStyle(
          //Para dar responsividade ao tamanho de texto
          fontSize: 20 * mediaQuerry.textScaleFactor,
        ),
      ),
      centerTitle: false,
      elevation: 0,
      actions: actions,
    );
    //Obtendo o tamanho da tela e subtraindo o app bar e barra de status
    final availableHeight = mediaQuerry.size.height -
        appBar.preferredSize.height -
        mediaQuerry.padding.top;

    final bodyPage = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Botão para exibição do grafico ou lista
          //  if(isLandscape)
          //  Row(
          //    mainAxisAlignment: MainAxisAlignment.center,
          //    children: [
          //      const Text("Exibir Gráfico"),
          //  //adaptative serve para que o switch se adapte depedendo da platarforma.
          //      Switch.adaptive(
          //        activeColor: Theme.of(context).colorScheme.secondary,
          //          value: _showChart,
          //          onChanged: (value){
          //        setState(() {
          //          _showChart = value;
          //        });
          //      }),
          //    ],
          //  ),
          if (_showChart || !isLandscape)
            //GRÁFICO
            SizedBox(
                //Deixando o componante responsivo permintindo ocupar um certo percentual do tamanho da tela.
                height: availableHeight * (isLandscape ? 0.75 : 0.25),
                child: Chart(recentTransaction: _recentTransactions)),
          if (!_showChart || !isLandscape)
            //LISTA
            SizedBox(
              height: availableHeight * (isLandscape ? 1 : 0.75),
              child: TransactionList(
                transactions: _transactions,
                onRemove: _removeTransaction,
              ),
            ),
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            appBar: appBar,
            body: bodyPage,
            //Verificando qual platarfoma estou e exibindo o floatingButton ou não
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _openTransactionFormModal(context),
                    child: const Icon(Icons.add),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
