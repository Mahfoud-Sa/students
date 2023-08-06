import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/Models/user.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';
import 'package:students/ViewModels/users_view_model.dart';
import 'package:students/Views/personal_detailes_edit_page.dart';
import 'package:students/Views/personal_detailes_page.dart';
import 'package:students/Views/singin_page.dart';
import 'package:students/utiles/navigations_utiles.dart';

class UsersPage extends StatelessWidget {
  UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    var userViewModel = Provider.of<UsersViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: userViewModel.getusers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(snapshot.data![index].userName!),
                    subtitle: Text(snapshot.data![index].id.toString()!),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        pushNavigateTo(context,
                            PersonalDetailes(index: snapshot.data![index].id!));
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No Users'),
              );
            }
          }
          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            pushNavigateTo(context, SinginScreen());
          }),
    );
  }
}
