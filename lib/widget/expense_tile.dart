import 'package:expenses/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;
  ExpenseTile(
      {super.key,
      required this.name,
      required this.amount,
      required this.dateTime,
      required this.deleteTapped});

  @override
  Widget build(BuildContext context) {
    return Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),

          // SlidableAction(onPressed: deleteTapped,
          // icon: Icons.edit,
          // backgroundColor: Colors.green,
          // borderRadius: BorderRadius.circular(8),
          // ),
        ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Container(
            // height: 80,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 12.0,
                      spreadRadius: 1.0),
                  BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(-4.0, -4.0),
                      blurRadius: 12.0,
                      spreadRadius: 1.0),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: GoogleFonts.lora(
                              color: ColorConstant.itemNameColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                              decorationStyle: TextDecorationStyle.wavy),
                        ),
                      ),
                      Text(
                        '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                        style: GoogleFonts.lora(
                            color: ColorConstant.dateColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            wordSpacing: 0.5,
                            decorationStyle: TextDecorationStyle.wavy),
                      ),
                    ],
                  ),
                  Text(
                    '${amount}',
                    style: GoogleFonts.lora(
                        color: ColorConstant.amountColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        wordSpacing: 0.5,
                        decorationStyle: TextDecorationStyle.wavy),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
