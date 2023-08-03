import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/ViewModels/homeVM.dart';
import 'package:students/Views/login_page.dart';
import 'package:students/Views/personal_detailes_page.dart';
import 'package:students/providers/current_user_provider.dart';

class HomePage extends StatelessWidget {
  HomeVM data = HomeVM();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUserProvider>(
      builder: (context, value, child) {
        return Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                    accountEmail: Text(value.CurrentUser.password!),
                    accountName: Text(value.CurrentUser.userName!)),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Personal Detailes'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => PersonalDetailes()),
                    );
                  },
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () {
                        var provider = Provider.of<CurrentUserProvider>(context,
                            listen: false);
                        provider.logOut();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
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
          body: Text('welcome'),
        );
      },
    );
  }
}
