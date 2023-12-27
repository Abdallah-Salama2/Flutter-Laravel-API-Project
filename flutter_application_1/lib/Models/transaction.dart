class Transaction {
  int id;
  int categoryId;
  String description;
  String amount;
  String transactionDate;
  String createdAt;

  Transaction({
    required this.id,
    required this.categoryId,
    required this.description,
    required this.amount,
    required this.transactionDate,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      description: json['description'] ?? '',
      amount: json['amount'] ?? '0.00',
      transactionDate: json['transaction_date'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
