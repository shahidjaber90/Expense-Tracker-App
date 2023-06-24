import 'package:expenses/bar%20graph/bar_graph.dart';
import 'package:expenses/data/expense_data.dart';
import 'package:expenses/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  double calculateMax(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];
    values.sort();
    max = values.last * 1.1;

    return max == 0 ? 100 : max;
  }

  String calculateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];

    double total = 0;
    for (var i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String sunday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 6),
            child: Row(
              children: [
                Text(
                  'Week Total:',
                  style: GoogleFonts.lora(
                      color: ColorConstant.itemNameColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      decorationStyle: TextDecorationStyle.wavy),
                ),
                Text(
                  calculateWeekTotal(value, sunday, monday, tuesday, wednesday,
                      thursday, friday, saturday),
                  style: GoogleFonts.lora(
                      color: ColorConstant.amountColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      decorationStyle: TextDecorationStyle.wavy),
                )
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: calculateMax(value, sunday, monday, tuesday, wednesday,
                  thursday, friday, saturday),
              sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
              monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
              tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
              wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
              thrAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
              friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
              satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
