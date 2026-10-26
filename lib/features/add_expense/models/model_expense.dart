class ModelExpense {
  final String title;
  final double amount;
  final String category;
  final DateTime date;

  const ModelExpense({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  Map<String, Object> toJson() => {
    'title': title,
    'amount': amount,
    'category': category,
    'date': date.toIso8601String(),
  };

  factory ModelExpense.fromJson(Map<String, dynamic> json) {
    return ModelExpense(
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      category: json['category'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }
}
