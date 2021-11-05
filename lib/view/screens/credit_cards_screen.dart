import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task_analysis/network_module/api_response.dart';
import 'package:task_analysis/provider/credit_card_provider.dart';
import 'package:task_analysis/view/widgets/credit_card_widget.dart';
import 'package:task_analysis/view/widgets/dialogs_widget.dart';

class CreditCardPage extends StatelessWidget {
  const CreditCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text('Add Credit card'),
          onPressed: () {
            showCreditCardForm(context);
          },
        ),
        body: Consumer<CreditCardProvider>(
            builder: (context, creditCardProvider, widget) {
          if (creditCardProvider.creditCards.status == Status.COMPLETED) {
            return ListView(
              children: creditCardProvider.creditCards.data!
                  .map((e) => CreditCardWidget(creditCard: e))
                  .toList(),
            );
          }

          if (creditCardProvider.creditCards.status == Status.LOADING) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              showLoadingIndicator(context);
            });
            return Container();
          }

          if (creditCardProvider.creditCards.status == Status.ERROR) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              showMessageDialog(
                context,
                creditCardProvider.creditCards.message ?? '',
              );
            });

            return Container();
          }
          return Center(
            child: Text('CreditCard Page'),
          );
        }),
      ),
    );
  }
}

void showCreditCardForm(BuildContext context) {
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  showDialog(
    context: context,
    barrierColor: Colors.white70,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white60,
        elevation: 1,
        insetPadding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<CreditCardProvider>(builder: (context, cc, w) {
              Color color = Theme.of(context).primaryColor;
              if (cc.cardColor == 'red') {
                color = Colors.red;
              }
              if (cc.cardColor == 'blue') {
                color = Colors.blue;
              }
              if (cc.cardColor == 'green') {
                color = Colors.green;
              }
              return Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: _creditCardTextField(
                              controller: _bankNameController,
                              hintText: 'Bank Name',
                              maxLength: 10,
                            ),
                            width: 200,
                          ),
                          Image.asset(
                            'assets/contact_less.png',
                            height: 20,
                            width: 20,
                          )
                        ]),
                    _creditCardTextField(
                      controller: _numberController,
                      hintText: 'xxxx xxxx xxxx xxxx',
                      maxLength: 16,
                      keyboardType: TextInputType.number,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: _creditCardTextField(
                              controller: _expiryDateController,
                              hintText: 'Expiry date',
                              maxLength: 4,
                              keyboardType: TextInputType.number,
                            ),
                            width: 150,
                          ),
                          SizedBox(
                            child: _creditCardTextField(
                              controller: _cvvController,
                              hintText: 'cvv',
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                            ),
                            width: 100,
                          ),
                        ]),
                    _creditCardTextField(
                      controller: _nameController,
                      hintText: 'Name on card',
                    )
                  ],
                ),
              );
            }),
            Row(
              children: [
                cardBgColor(context, 'black'),
                cardBgColor(context, 'red'),
                cardBgColor(context, 'blue'),
                cardBgColor(context, 'green'),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Provider.of<CreditCardProvider>(context, listen: false)
                        .createCreditCard(
                      nameOnCard: _nameController.text,
                      bankName: _bankNameController.text,
                      cardCVV: _cvvController.text,
                      cardNumber: _numberController.text,
                      expriryDate: _expiryDateController.text,
                    );
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.send_rounded),
                )
              ],
            )
          ],
        ),
      );
    },
  );
}

Widget cardBgColor(BuildContext context, String color) {
  Color iconColor = Theme.of(context).primaryColor;
  if (color == 'red') {
    iconColor = Colors.red;
  }
  if (color == 'blue') {
    iconColor = Colors.blue;
  }
  if (color == 'green') {
    iconColor = Colors.green;
  }
  return IconButton(
    alignment: Alignment.centerLeft,
    onPressed: () {
      Provider.of<CreditCardProvider>(context, listen: false)
          .setCreditCardColor(color);
    },
    icon: Icon(
      Icons.label,
      color: iconColor,
    ),
  );
}

Widget _creditCardTextField({
  required TextEditingController controller,
  required String hintText,
  int? maxLength,
  TextInputType keyboardType = TextInputType.name,
}) {
  return TextFormField(
    maxLength: maxLength,
    controller: controller,
    keyboardType: keyboardType,
    inputFormatters: keyboardType == TextInputType.number
        ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
        : null,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      counterText: "",
      hintStyle: TextStyle(fontSize: 17, color: Colors.white),
      hintText: hintText,
      focusColor: Colors.white,
      border: InputBorder.none,
    ),
  );
}
