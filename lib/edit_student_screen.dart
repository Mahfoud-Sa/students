import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:students/main.dart';
import 'package:students/sqflite.dart';

class EditStudentPage extends StatefulWidget {
  final student;
  EditStudentPage({required this.student, super.key});

  @override
  State<EditStudentPage> createState() => _EditStudentPageState();
}

class _EditStudentPageState extends State<EditStudentPage> {
  SqlDb sql = SqlDb();
  final formstate = GlobalKey<FormState>();

  TextEditingController nameCont = TextEditingController();
  TextEditingController colCont = TextEditingController();
  TextEditingController depCont = TextEditingController();
  TextEditingController levCont = TextEditingController();
  String? gender = 'Male';

  @override
  void initState() {
    super.initState();
    nameCont.text = widget.student['name'].toString();
    colCont.text = widget.student['collage'].toString();
    depCont.text = widget.student['department'].toString();
    levCont.text = widget.student['level'].toString();
    String gender = widget.student['gender'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Student'),
        ),
        body: Form(
          key: formstate,
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 60,
                backgroundColor: widget.student['gender'] == 'Male'
                    ? const Color.fromARGB(255, 3, 161, 252)
                    : const Color.fromARGB(255, 252, 3, 148),
              ),
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
                controller: depCont,
                decoration:
                    const InputDecoration(hintText: 'Student department'),
              ),

              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Student Department!!';
                  }
                  return null;
                },
                controller: colCont,
                decoration:
                    const InputDecoration(hintText: 'Student department'),
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
                        sql.updateData('''
                            update 'students' set 'name'="${nameCont.text}", 'collage'="${colCont.text}",'department'="${depCont.text}",'level'="${levCont.text}",'gender'="${gender}" where id=${widget.student['id']} 
                           
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
                    child: const Text('Save Student')),
              )
            ],
          ),
        ));
  }
}
