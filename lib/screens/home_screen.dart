import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff581845),
          title: const Text("Despesas Pessoais"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Card(
              child: Text("Gráfico"),
            ),
            Card(
              child: Text("Lista"),
            )
          ],
        )
      ),
    );
  }
}


// #900c3f
// #581845