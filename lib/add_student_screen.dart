import 'package:flutter/material.dart';
import 'package:students/main.dart';
import 'package:students/sqflite.dart';
//void main() => runApp(const MyApp());

class AddStudentPage extends StatefulWidget {
  AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  SqlDb sql = SqlDb();
  final formstate = GlobalKey<FormState>();

  TextEditingController nameCont = TextEditingController();
  TextEditingController colCont = TextEditingController();
  TextEditingController depCont = TextEditingController();
  TextEditingController levCont = TextEditingController();
  String? gender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Student'),
        ),
        body: Form(
          key: formstate,
          child: ListView(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Student Name!!';
                  }
                  return null;
                },
                controller: nameCont,
                decoration: const InputDecoration(hintText: 'Student Name'),
              ),
              //student collage
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Student Collage!!';
                  }
                  return null;
                },
                controller: colCont,
                decoration: const InputDecoration(hintText: 'Student Collage'),
              ),
              //Department
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Student Depatment!!';
                  }
                  return null;
                },
                controller: depCont,
                decoration: const InputDecoration(hintText: 'Department'),
              ),
              //Level
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Student Level!!';
                  }
                  return null;
                },
                controller: levCont,
                decoration: const InputDecoration(hintText: 'Student Level'),
              ),
              //Gender
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(
                  height: 20,
                ),
                const Text('Gender : '),
                Row(
                  children: [
                    Row(
                      children: [
                        const Text('Male'),
                        Radio(
                          value: 'Male',
                          groupValue: gender,
                          onChanged: (String? value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Female'),
                        Radio(
                          value: 'Female',
                          groupValue: gender,
                          onChanged: (String? value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (formstate.currentState!.validate()) {
                        sql.insertData('''
                          INSERT INTO "students" ('name', 'collage','department','level','gender')
                          VALUES ("${nameCont.text}","${colCont.text}","${depCont.text}","${levCont.text}","${gender}")
                          ''');

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                showCloseIcon: true,
                                backgroundColor: Colors.green,
                                content: Text('Done')));
                      }
                    },
                    child: const Text('Add Student')),
              ),
            ],
          ),
        ));
  }
}
