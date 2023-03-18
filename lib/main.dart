import 'package:flutter/material.dart';
import 'package:students/sqflite.dart';
import 'package:students/add_student_screen.dart';
import 'package:students/student_detailes.dart';

void main() {
  runApp(Students());
}

class Students extends StatefulWidget {
  Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Students List',
      //themeMode: ThemeMode.dark,
      //darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sql = SqlDb();

  late List students = [];

  Future<List<Map>> getStudents() async {
    List<Map> response = await sql.readData();
    students.addAll(response);
    if (mounted) {
      setState(() {});
    }
    return response;
  }

  void initState() {
    super.initState();
    getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students List'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      StudentDetailes(student: students[index])));
            },
            leading: students[index]['gender'] == 'Male'
                ? const Icon(
                    Icons.man_4,
                    color: Color.fromARGB(255, 3, 161, 252),
                  )
                : const Icon(
                    Icons.woman_sharp,
                    color: Color.fromARGB(255, 252, 3, 148),
                  ),
            title: Text(students[index]['name']),
            subtitle: Text(students[index]['collage']),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                await sql.deleteData(students[index]['id']);
                students.removeAt(index);
                setState(() {});
              },
            ),
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddStudentPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
