import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/Models/user.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';
import 'package:students/Views/login_page.dart';
import 'package:students/Views/personal_detailes_edit_page.dart';
import 'package:students/ViewModels/users_view_model.dart';
import 'package:students/utiles/navigations_utiles.dart';

import 'home_page.dart';

class PersonalDetailes extends StatefulWidget {
  final index;

  PersonalDetailes({super.key, this.index});

  @override
  State<PersonalDetailes> createState() => _PersonalDetailesState();
}

class _PersonalDetailesState extends State<PersonalDetailes> {
  late Future<User> _user;

  TextEditingController passCont = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = getUser();
  }

  Future<User> getUser() async {
    var user = await UsersViewModel().getUser(widget.index);
    return user;
  }

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
                  userViewModel.navigateToUserDetailesEdit(
                      context, widget.index);
                },
                icon: Icon(Icons.edit))
          ],
        ),
        body: Center(
            child: FutureBuilder(
          future: _user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(snapshot.data!.id.toString()),
                    Text(snapshot.data!.userName!),
                    Text(snapshot.data!.password!),
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
                                      var deleteState =
                                          await userViewModel.deletetUser(
                                              widget.index, passCont.text);

                                      if (deleteState == "Done") {
                                        removeNavigatTo(context, LoginScreen());

                                        userViewModel.logOut();
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
        )));
  }
}
