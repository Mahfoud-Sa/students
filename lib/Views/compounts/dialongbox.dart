import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/ViewModels/users_view_model.dart';
import 'package:students/Views/login_page.dart';

class MyAlertDialong extends StatelessWidget {
  const MyAlertDialong({super.key});

  @override
  Widget build(BuildContext context) {
    var userViewModel = Provider.of<UsersViewModel>(context);

    TextEditingController passCont = TextEditingController();
    return AlertDialog(
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
              var deleteState =
                  await userViewModel.deletetUser(index, passCont.text);

              if ('deleteState' == "Done") {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
                //var provider =
                // Provider.of<UsersViewModel>(context,
                //  listen: false);
                //  provider.logOut();
              } else {
                Navigator.of(context).pop();
              }
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  showCloseIcon: true,
                  backgroundColor:
                      'deleteState' != 'Done' ? Colors.red : Colors.green,
                  content: Text('deleteState')));
            }),
        TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
    );
  }
}
