import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/Models/user.dart';
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
  late Future<User> user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = getCurrentUser();
  }

  Future<User> getCurrentUser() async {
    var user = await UsersViewModel().getCurrentUser();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    var userViewModel = Provider.of<UsersViewModel>(context);

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            FutureBuilder(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return UserAccountsDrawerHeader(
                          accountName: Text(snapshot.data!.userName!),
                          accountEmail: Text(snapshot.data!.password!));
                    }
                  }
                  return CircularProgressIndicator();
                }),
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
                    userViewModel.logOut();
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
