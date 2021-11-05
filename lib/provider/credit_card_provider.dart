import 'package:flutter/foundation.dart';
import 'package:task_analysis/helpers/db_helper.dart';
import 'package:task_analysis/models/credit_cards.dart';
import 'package:task_analysis/network_module/api_response.dart';

class CreditCardProvider with ChangeNotifier {
  late ApiResponse<CreditCard> _creditCard;
  ApiResponse<CreditCard> get creditCard => _creditCard;

  late ApiResponse<List<CreditCard>> _creditCards;
  ApiResponse<List<CreditCard>> get creditCards => _creditCards;

  String cardColor = 'blue';

  setCreditCardColor(String color) {
    cardColor = color;
    notifyListeners();
  }

  void createCreditCard({
    required String nameOnCard,
    required String bankName,
    required String cardCVV,
    required String cardNumber,
    required String expriryDate,
  }) async {
    final CreditCard creditCard = CreditCard(
      userId: 1,
      bankName: bankName,
      cardCvv: cardCVV,
      cardNumber: cardNumber,
      expriryDate: expriryDate,
      nameOnCard: nameOnCard,
      cardColor: cardColor,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    try {
      await TasksAnalysisDatabase.instance.createCreditCard(creditCard);
      getAllCreditCards();
    } catch (e) {
      print(e);
      print('something went wrong');
    }
  }

  void getAllCreditCards() async {
    try {
      _creditCards = ApiResponse.loading('loading...');
      notifyListeners();
      List<CreditCard> creditCardsList =
          await TasksAnalysisDatabase.instance.readAllCreditCards();
      _creditCards = ApiResponse.completed(creditCardsList);
      print(creditCardsList);
      notifyListeners();
    } catch (e) {
      _creditCards = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
