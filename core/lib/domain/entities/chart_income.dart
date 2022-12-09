class ChartIncome {
  final String category;
  final double amount;

  ChartIncome(this.category, this.amount);

  factory ChartIncome.fromMap(Map<dynamic, dynamic> data) {
    return ChartIncome(
      data['category'] as String,
      data['amount'].toDouble(),
    );
  }
}
