import 'package:flutter/material.dart';
import 'package:students/Views/home_page.dart';
import 'package:students/Views/login_page.dart';
import 'package:students/Views/singin_page.dart';
import 'package:students/providers/current_user_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return AppProbider();
        }),
        ChangeNotifierProvider(create: (context) {
          return CurrentUserProvider();
        }),
      ],
      child: Consumer<AppProbider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Students List',
            themeMode: provider.darkTheme ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData.dark(),
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Splash(),
          );
        },
      ),
    );
  }
}

//وقفت عند فحص الرسبونس حق التعديل لليوزر

class Splash extends StatelessWidget {
  Splash({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CurrentUserProvider>(context);

    return FutureBuilder(
      future: provider.IsLoging(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return HomePage();
            } else {
              return LoginScreen();
            }
          }
        } else {
          return CircularProgressIndicator();
        }
        return CircularProgressIndicator();
      },
    );
  }
}


//وقفت عند تسجيل خاصية البقاء مسجلا