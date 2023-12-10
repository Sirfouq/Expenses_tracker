// ignore_for_file: unused_import
import 'package:expenses_tracker/model/expenseCategory.dart';
import 'package:flutter/material.dart';

class Expense{
  
   int id;
   double amount;
   DateTime date;
   String? description;
   int expenseCategory_id;

   Expense({required this.id,required this.amount,required this.date,required this.expenseCategory_id});


}