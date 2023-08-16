import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/Models/user.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';
import 'package:students/Views/login_page.dart';
import 'package:students/Views/personal_detailes_edit_page.dart';
import 'package:students/ViewModels/users_view_model.dart';
import 'package:students/Views/snak_bar.dart';
import 'package:students/Views/widgets/student_feild.dart';
import 'package:students/utiles/navigations_utiles.dart';

import 'home_page.dart';

class PersonalDetailes extends StatelessWidget {
  final User user;
  PersonalDetailes({super.key, required this.user});

  TextEditingController passCont = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userViewModel = Provider.of<UsersViewModel>(context);

    Future OpenDialonge() {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete Account"),
            //icon: Icon(Icons.dangerous),

            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter Your Password To converm",
                  style: TextStyle(fontSize: 12),
                ),
                TextFormField(
                  obscureText: true,
                  controller: passCont,
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    String state = await userViewModel.deletetUser(
                        user.id!, passCont.text);
                    if (state == "Done") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          showCloseIcon: true,
                          backgroundColor: Colors.red,
                          content: Text('Done')));
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          showCloseIcon: true,
                          backgroundColor: Colors.red,
                          content: Text('Password Error')));
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Converm"))
            ],
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Personal Detailes'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  pushNavigateTo(context, PersonalDetailesEdit(user: user));
                },
                icon: Icon(Icons.edit))
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/student_image.jpg"))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                StudentFeild(
                    feildName: "Name",
                    feildString: "${user.fullName!} ${user.lastName!}"),
                StudentFeild(
                    feildName: "User Name", feildString: "${user.userName}"),
                StudentFeild(
                    feildName: "Age", feildString: "${user.getBirthDay()}"),
                StudentFeild(
                    feildName: "Gender",
                    feildString: "${(user.gender == 1 ? 'Male' : 'Femail')}"),
                StudentFeild(
                    feildName: "Address",
                    feildString:
                        "${user.country} ${user.city} ${user.neighborhood}"),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          OpenDialonge();
                        },
                        child: Text(
                          "Delete My Account",
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.redAccent),
                        ),
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)))),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
