// ignore_for_file: unused_import

import 'package:flutter/material.dart';


class ExpenseCategory {

  int? id;
  String name;
  String icon_codekey;
 

  ExpenseCategory({this.id,required this.name,required this.icon_codekey});

   Map<String,dynamic> toMap(){
    return {
      'name':name,
      'icon_codekey': icon_codekey
      
    };
  }

    static ExpenseCategory fromMap(Map<String,dynamic> map){
      return ExpenseCategory(
        id:map['id'],
        name: map['name'],
        icon_codekey: map['icon_codekey']
        );
    }
  

}