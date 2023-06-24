/// ExpensesForm is a data class which stores data fields of Expenses.
class ExpensesForm {
  String date;
  String particulars;
  String rate;
  String qty;
  // String amount;
  // String credit;
  // String balance_amount;

  ExpensesForm(this.date, this.particulars, this.rate, this.qty);

  factory ExpensesForm.fromJson(dynamic json) {
    return ExpensesForm("${json['date']}", "${json['particulars']}",
        "${json['rate']}", "${json['qty']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'date': date,
        'particulars': particulars,
        'rate': rate,
        'qty': qty,
        // 'amount': amount,
        // 'credit': credit,
        // 'balance_amount': balance_amount
      };
}