import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/Models/user_model.dart';
import 'package:students/ViewModels/personal_detailesVM.dart';
import 'package:students/providers/current_user_provider.dart';

import '../ViewModels/personal_detailes_editVM.dart';

class PersonalDetailesEdit extends StatelessWidget {
  PersonalDetailesEditVM data = PersonalDetailesEditVM();
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    // super.dispose();
  }

  PersonalDetailesEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Personal Detailes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'User Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter user name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password ';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.0),
                    TextFormField(
                      controller: _repeatPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Repeat Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Repeat password ';
                        }
                        if (value != _passwordController.text) {
                          return 'Password do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.0),
                    TextButton(
                        child: Text('save'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            UserModel usr = UserModel(
                                userName: _usernameController.text,
                                password: _passwordController.text);
                            String editePersonalDetailesState =
                                await data.edit(usr);
                            if (editePersonalDetailesState ==
                                'Updated Susseccfly') {
                              var provider = Provider.of<CurrentUserProvider>(
                                  context,
                                  listen: false);
                              provider.SetCurrentUser();
                              Navigator.pop(context);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                showCloseIcon: true,
                                backgroundColor: editePersonalDetailesState !=
                                        'Updated Susseccfly'
                                    ? Colors.red
                                    : Colors.green,
                                content: Text('$editePersonalDetailesState')));

                            // Add your login logic using the entered username and password
                          }
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
