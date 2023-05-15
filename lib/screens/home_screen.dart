import 'package:expenses/components/transaction_user.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff581845),
            title: const Text("Despesas Pessoais"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Card(
                  child: Text("Gráfico"),
                ),
                TransactionUser(),
              ],
            ),
          )),
    );
  }
}

// #900c3f
// #581845
