import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/Views/login_page.dart';
import 'package:students/Views/personal_detailes_page.dart';
import 'package:students/ViewModels/users_view_model.dart';
import 'package:students/Views/users_page.dart';
import 'package:students/utiles/navigations_utiles.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var userViewModel = Provider.of<UsersViewModel>(context);

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountEmail: FutureBuilder(
                future: userViewModel.getCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(snapshot.data!.userName!);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              accountName: FutureBuilder(
                future: userViewModel.getCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(snapshot.data!.password!);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Personal Detailes'),
              onTap: () {
                pushNavigateTo(
                    context,
                    PersonalDetailes(
                      index: userViewModel.CurrentUser.id,
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Users'),
              onTap: () {
                pushNavigateTo(context, UsersPage());
              },
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    var provider =
                        Provider.of<UsersViewModel>(context, listen: false);
                    provider.logOut();
                    removeNavigatTo(context, HomePage());
                  },
                ),
              ],
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Students List'),
      ),
      body: Placeholder(),
    );
  }
}
