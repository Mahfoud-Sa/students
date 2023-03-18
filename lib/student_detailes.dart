import 'package:flutter/material.dart';
import 'package:students/edit_student_screen.dart';
import 'package:students/main.dart';
import 'package:students/sqflite.dart';

class StudentDetailes extends StatelessWidget {
  var student;
  StudentDetailes({required this.student, super.key});

  // SqlDb sql = SqlDb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Student Detailes'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditStudentPage(
                            student: student,
                          )));
                },
                icon: Icon(Icons.edit))
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 60,
                backgroundColor: student['gender'] == 'Male'
                    ? const Color.fromARGB(255, 3, 161, 252)
                    : const Color.fromARGB(255, 252, 3, 148),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  student['gender'] == 'Male'
                      ? Text("اسم الطالب: ${student['name']}")
                      : Text("اسم الطالبة : ${student['name']}"),
                  Text("رقم القيد : ${student['id']}"),
                  Text("الكلية : ${student['collage']}"),
                  Text("القسم : ${student['department']}"),
                  Text("المستوئ : ${student['level']}")
                ],
              ),
            ],
          ),
        ));
  }
}
