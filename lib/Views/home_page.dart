import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/Views/login_page.dart';
import 'package:students/Views/personal_detailes_page.dart';
import 'package:students/ViewModels/users_view_model.dart';
import 'package:students/Views/users_page.dart';
import 'package:students/utiles/navigations_utiles.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var userViewModel = Provider.of<UsersViewModel>(context);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(userViewModel.CurrentUser.fullName!),
                accountEmail: Text(userViewModel.CurrentUser.userName!)),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Personal Detailes'),
              onTap: () {
                pushNavigateTo(
                    context,
                    PersonalDetailes(
                      user: userViewModel.CurrentUser,
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
                    userViewModel.logOut();
                    removeNavigatTo(context, LoginScreen());
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
