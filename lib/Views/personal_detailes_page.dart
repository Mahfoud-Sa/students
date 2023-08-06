import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';
import 'package:students/Views/login_page.dart';
import 'package:students/Views/personal_detailes_edit_page.dart';
import 'package:students/ViewModels/users_view_model.dart';

import 'home_page.dart';

class PersonalDetailes extends StatelessWidget {
  final index;
  TextEditingController passCont = new TextEditingController();
  PersonalDetailes({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    var userViewModel = Provider.of<UsersViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Personal Detailes'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  userViewModel.navigateToUserDetailesEdit(context, index);
                },
                icon: Icon(Icons.edit))
          ],
        ),
        body: FutureBuilder(
          future: userViewModel.getUser(index),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                //var userName;
                return Column(
                  children: [
                    Text(snapshot.data!.id.toString()),
                    Text(snapshot.data!.userName.toString()),
                    Text(snapshot.data!.password.toString()),
                    TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("delete account"),
                              content: Column(
                                children: [
                                  Text(
                                      "are you shure you want to delete your account"),
                                  TextField(
                                    controller: passCont,
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                    child: Text('Continue'),
                                    onPressed: () async {
                                      var deleteState = await userViewModel
                                          .deletetUser(index, passCont.text);

                                      if (deleteState == "Done") {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen()),
                                                (route) => false);
                                        var provider =
                                            Provider.of<UsersViewModel>(context,
                                                listen: false);
                                        provider.logOut();
                                      } else {
                                        Navigator.of(context).pop();
                                      }
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              showCloseIcon: true,
                                              backgroundColor:
                                                  deleteState != 'Done'
                                                      ? Colors.red
                                                      : Colors.green,
                                              content: Text('$deleteState')));
                                    }),
                                TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ],
                            ),
                          );
                        },
                        child: Text('Delete My account'))
                  ],
                );
              }
            }
            return CircularProgressIndicator();
          },
        ));
  }
}
