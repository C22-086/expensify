import 'package:intl/intl.dart';

final formatCurrency = NumberFormat.compactCurrency(
  locale: "id_ID",
  symbol: "Rp. ",
  decimalDigits: 0,
);

final formatBalance = NumberFormat.currency(
  locale: "id_ID",
  symbol: "Rp. ",
  decimalDigits: 0,
);
