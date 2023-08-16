import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/Models/user.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';
import 'package:students/ViewModels/users_view_model.dart';
import 'package:students/Views/add_user_page.dart';
import 'package:students/Views/personal_detailes_edit_page.dart';
import 'package:students/Views/personal_detailes_page.dart';
import 'package:students/Views/singin_page.dart';
import 'package:students/Views/widgets/student_list_tile.dart';
import 'package:students/utiles/navigations_utiles.dart';

class UsersPage extends StatefulWidget {
  UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late Future<List<User>> users;
  void initState() {
    // TODO: implement initState
    super.initState();
    //users = getUsers();
  }

  Future<List<User>> getUsers() async {
    var user = await UsersViewModel().getusers();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    var userViewModel = Provider.of<UsersViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: userViewModel.users.length,
          itemBuilder: (context, index) {
            return StudentListTile(user: userViewModel.users[index]);
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            pushNavigateTo(context, AddUserPage());
          }),
    );
  }
}
