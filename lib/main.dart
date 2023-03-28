import 'package:flutter/material.dart';
import 'package:students/sqflite.dart';
import 'package:students/add_student_screen.dart';
import 'package:students/student_detailes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Students());
}

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  //final SharedPreferences setting = await SharedPreferences().getInstance();

  @override
  void initState() {
    super.initState();
    //themeMode = getSetting() as bool ? ThemeMode.light : ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProbider>(create: ((context) {
      return AppProbider();
    }), child: Consumer<AppProbider>(
      builder: (context, provider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Students List',
          themeMode: provider.darkTheme ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark(),
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage(),
        );
      },
    ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sql = SqlDb();
  AppProbider theme = AppProbider();
  getTheme() async {
    theme.darkTheme = await theme.darkThemePreference.getThene();
  }

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
    getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProbider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Students List'),
          actions: [
            IconButton(
                onPressed: () {
                  value.darkTheme = !value.darkTheme;
                },
                icon: value.darkTheme
                    ? const Icon(Icons.light_mode)
                    : const Icon(Icons.dark_mode))
          ],
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
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddStudentPage()));
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
