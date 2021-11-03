import 'package:flutter/material.dart';

class CreditCardPage extends StatelessWidget {
  const CreditCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text('Add Credit card'),
          onPressed: () {},
        ),
        body: Center(
          child: Text('CreditCard Page'),
        ),
      ),
    );
  }
}
