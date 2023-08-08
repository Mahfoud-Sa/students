import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/Repository/UsersRepository/users_local.dart';
import 'package:students/ViewModels/login_view_model.dart';
import 'package:students/Views/home_page.dart';
import 'package:students/Views/singin_page.dart';
import 'package:students/main.dart';
import 'package:students/ViewModels/users_view_model.dart';
import 'package:students/utiles/navigations_utiles.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginViewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/login_image.jpg'),
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
                          return 'Enter password name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.0),
                    TextButton(
                        child: Text('Login'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String logInMessage = await loginViewModel.logIn(
                                _usernameController.text,
                                _passwordController.text);
                            if (logInMessage == 'Welcome') {
                              pushNavigateTo(context, HomePage());
                            }

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                showCloseIcon: true,
                                backgroundColor: logInMessage != 'Welcome'
                                    ? Colors.red
                                    : Colors.green,
                                content: Text('$logInMessage')));
                          }
                        }),
                    TextButton(
                        onPressed: () {
                          {
                            pushNavigateTo(context, SinginScreen());
                          }
                        },
                        child: Text('do not have an account? sing in '))
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
