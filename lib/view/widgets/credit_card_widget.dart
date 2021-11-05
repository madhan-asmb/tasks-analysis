import 'package:flutter/material.dart';

import 'package:task_analysis/models/credit_cards.dart';

class CreditCardWidget extends StatelessWidget {
  final CreditCard creditCard;
  const CreditCardWidget({
    Key? key,
    required this.creditCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    if (creditCard.cardColor == 'red') {
      color = Colors.red;
    }
    if (creditCard.cardColor == 'blue') {
      color = Colors.blue;
    }
    if (creditCard.cardColor == 'green') {
      color = Colors.green;
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Theme.of(context).primaryColor, blurRadius: 4)
          ]),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                creditCard.bankName.toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Image.asset(
                'assets/contact_less.png',
                height: 20,
                width: 20,
              )
            ],
          ),
          SizedBox(height: 4),
          Text(
            creditCard.cardNumber,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Exp Date ${creditCard.expriryDate}',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'CVV ${creditCard.cardCvv}',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            creditCard.nameOnCard.toUpperCase(),
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
