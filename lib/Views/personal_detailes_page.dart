import 'package:flutter/material.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';
import 'package:students/ViewModels/personal_detailesVM.dart';
import 'package:students/Views/login_page.dart';
import 'package:students/Views/personal_detailes_edit_page.dart';

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
          FutureBuilder(
            future: data.getUserName(),
            builder: (context, snapshot) {
              return Text(snapshot.data.toString());
            },
          ),
          FutureBuilder(
            future: data.getPasswordName(),
            builder: (context, snapshot) {
              return Text(snapshot.data.toString());
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
