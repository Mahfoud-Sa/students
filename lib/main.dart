import 'package:flutter/material.dart';
import 'package:students/Views/login_page.dart';
import 'package:students/Views/singin_page.dart';
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
          home: LoginScreen(),
        );
      },
    ));
  }
}
