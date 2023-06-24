import 'package:expenses/Model/exoense_item.dart';
import 'package:expenses/data/expense_data.dart';
import 'package:expenses/utils/colors.dart';
import 'package:expenses/widget/Textfield_widget.dart';
import 'package:expenses/widget/expense_summary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widget/expense_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController newExpenseNameController = TextEditingController();
  TextEditingController newExpenseAmountController = TextEditingController();
  TextEditingController newExpenseQuantityController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add New Expense',
                  style: GoogleFonts.lora(
                      color: Colors.blue,
                      // fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      decorationStyle: TextDecorationStyle.wavy)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Expense Name
                  // TextField(
                  //   controller: newExpenseNameController,
                  //   textCapitalization: TextCapitalization.words,
                  //   decoration: const InputDecoration(label: Text('Item Name')),
                  // ),
                  TextFieldWidget(
                      labelText: 'Item Name',
                      controllerField: newExpenseNameController,
                      type: TextInputType.text),

                  const SizedBox(
                    height: 16,
                  ),
                  // Expense Amount
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                            labelText: 'Rate',
                            controllerField: newExpenseAmountController,
                            type: TextInputType.number),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextFieldWidget(
                            labelText: 'Qty',
                            controllerField: newExpenseQuantityController,
                            type: TextInputType.number),
                        // TextField(
                        //   controller: newExpenseQuantityController,
                        //   keyboardType: TextInputType.number,
                        //   decoration: const InputDecoration(label: Text('Qty')),
                        // ),
                      ),
                    ],
                  )
                ],
              ),
              actions: [
                // Save Button
                TextButton(onPressed: save, child: Text('Save')),
                // Cancel Button
                TextButton(onPressed: cancel, child: Text('Cancel')),
              ],
            ));
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  double multiplyValues() {
    double value1 = double.tryParse(newExpenseAmountController.text) ?? 0;
    double value2 = double.tryParse(newExpenseQuantityController.text) ?? 0;
    return value1 * value2;
  }

  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty &&
        newExpenseQuantityController.text.isNotEmpty) {
      ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text,
          amount: multiplyValues().toString(),
          dateTime: DateTime.now());

      // add the new expense
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }

    newExpenseNameController.clear();
    newExpenseAmountController.clear();
    newExpenseQuantityController.clear();

    Navigator.pop(context);
  }

  void cancel() {
    Navigator.pop(context);
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
    newExpenseQuantityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ExpenseData>(
        builder: (context, value, child) => Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black,
              elevation: 0,
              onPressed: addNewExpense,
              child: const Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
            ),
            body: ListView(
              children: [
                const SizedBox(
                  height: 12,
                ),
                // weekly summary

                ExpenseSummary(startOfWeek: value.startOfWeekDate()),

                const SizedBox(
                  height: 12,
                ),

                // expense list
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.getAllExpenseList().length,
                  itemBuilder: (context, index) {
                    return ExpenseTile(
                        name: value.getAllExpenseList()[index].name,
                        amount: value.getAllExpenseList()[index].amount,
                        dateTime: value.getAllExpenseList()[index].dateTime,
                        deleteTapped: (p0) =>
                            deleteExpense(value.getAllExpenseList()[index]));
                  },
                ),
              ],
            )),
      ),
    );
  }
}
