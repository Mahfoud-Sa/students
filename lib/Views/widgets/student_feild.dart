import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:students/Models/user.dart';
import 'package:students/Views/personal_detailes_page.dart';
import 'package:students/utiles/navigations_utiles.dart';

class StudentFeild extends StatelessWidget {
  final String feildName;
  final String feildString;

  const StudentFeild(
      {super.key, required this.feildName, required this.feildString});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          feildName,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(feildString),
        ),
      ],
    );
  }
}
