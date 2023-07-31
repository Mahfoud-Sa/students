import 'package:flutter/material.dart';
import 'package:students/ViewModels/homeVM.dart';
import 'package:students/Views/personal_detailes_page.dart';

class HomePage extends StatelessWidget {
  HomeVM data = HomeVM();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                accountEmail: FutureBuilder(
                  future: data.getUserName(),
                  builder: (context, snapshot) {
                    return Text(snapshot.data.toString());
                  },
                ),
                accountName: Text('')),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Personal Detailes'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PersonalDetailes()),
                );
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Students List'),
      ),
      body: Text('welcome'),
    );
  }
}
