import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';
import 'package:students/ViewModels/personal_detailesVM.dart';
import 'package:students/Views/login_page.dart';
import 'package:students/Views/personal_detailes_edit_page.dart';
import 'package:students/providers/current_user_provider.dart';

import 'home_page.dart';

class PersonalDetailes extends StatelessWidget {
  PersonalDetailesVM data = PersonalDetailesVM();
  TextEditingController passCont = new TextEditingController();
  PersonalDetailes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Detailes'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => PersonalDetailesEdit()),
                );
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: Column(
        children: [
          Consumer<CurrentUserProvider>(
            builder: (context, value, child) {
              return Text(value.CurrentUser.userName!);
            },
          ),
          Consumer<CurrentUserProvider>(
            builder: (context, value, child) {
              return Text(value.CurrentUser.password!);
            },
          ),
          TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("delete account"),
                    content: Column(
                      children: [
                        Text("are you shure you want to delete your account"),
                        TextField(
                          controller: passCont,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                          child: Text('Continue'),
                          onPressed: () async {
                            var deleteState = await data.delete(passCont.text);
                            if (deleteState == "Done") {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (route) => false);
                              var provider = Provider.of<CurrentUserProvider>(
                                  context,
                                  listen: false);
                              provider.logOut();
                            } else {
                              Navigator.of(context).pop();
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                showCloseIcon: true,
                                backgroundColor: deleteState != 'Done'
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
      ),
    );
  }
}
