final String tableCreditCard = 'credit_cards';

class CreditCardFields {
  static final List<String> values = [
    id,
    bankName,
    nameOnCard,
    expriryDate,
    cardNumber,
    cardCvv,
    userId,
    cardColor,
    createdAt,
    updatedAt,
  ];

  static final String id = '_id';
  static final String bankName = 'bank_name';
  static final String nameOnCard = 'name_on_card';
  static final String expriryDate = 'expiry_date';
  static final String cardNumber = 'card_number';
  static final String cardCvv = 'card_cvv';
  static final String userId = 'user_id';
  static final String cardColor = 'card_color';
  static final String createdAt = 'created_at';
  static final String updatedAt = 'updated_at';
}

class CreditCard {
  final int? id;
  final int userId;
  final String bankName;
  final String nameOnCard;
  final String expriryDate;
  final String cardNumber;
  final String cardCvv;
  final String cardColor;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CreditCard({
    this.id,
    required this.userId,
    required this.bankName,
    required this.nameOnCard,
    required this.expriryDate,
    required this.cardNumber,
    required this.cardCvv,
    required this.cardColor,
    required this.createdAt,
    required this.updatedAt,
  });

  CreditCard copy({
    int? id,
    int? userId,
    String? bankName,
    String? nameOnCard,
    String? expriryDate,
    String? cardNumber,
    String? cardCvv,
    String? cardColor,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CreditCard(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        bankName: bankName ?? this.bankName,
        nameOnCard: nameOnCard ?? this.nameOnCard,
        cardNumber: cardNumber ?? this.cardNumber,
        expriryDate: expriryDate ?? this.expriryDate,
        cardCvv: cardCvv ?? this.cardCvv,
        cardColor: cardColor ?? this.cardColor,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  static CreditCard fromJson(Map<String, Object?> json) => CreditCard(
        id: json[CreditCardFields.id] as int?,
        userId: json[CreditCardFields.userId] as int,
        bankName: json[CreditCardFields.bankName] as String,
        nameOnCard: json[CreditCardFields.nameOnCard] as String,
        cardNumber: json[CreditCardFields.cardNumber] as String,
        expriryDate: json[CreditCardFields.expriryDate] as String,
        cardCvv: json[CreditCardFields.cardCvv] as String,
        cardColor: json[CreditCardFields.cardColor] as String,
        createdAt: DateTime.parse(json[CreditCardFields.createdAt] as String),
        updatedAt: DateTime.parse(json[CreditCardFields.updatedAt] as String),
      );

  Map<String, Object?> toJson() => {
        CreditCardFields.id: id,
        CreditCardFields.userId: userId,
        CreditCardFields.bankName: bankName,
        CreditCardFields.nameOnCard: nameOnCard,
        CreditCardFields.cardNumber: cardNumber,
        CreditCardFields.expriryDate: expriryDate,
        CreditCardFields.cardCvv: cardCvv,
        CreditCardFields.cardColor: cardColor,
        CreditCardFields.createdAt: createdAt.toIso8601String(),
        CreditCardFields.updatedAt: updatedAt.toIso8601String(),
      };
}
