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
  bool obsecure = true;
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/login_image.jpg'),
            ),
            Text(
              'log in to see your account',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: EdgeInsets.all(40.0),
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
                        suffixIcon: IconButton(
                          icon: !obsecure
                              ? Icon(Icons.lock_open)
                              : Icon(Icons.lock),
                          onPressed: () {
                            setState(() {
                              obsecure = !obsecure;
                            });
                          },
                        ),
                        labelText: 'Password',
                      ),
                      obscureText: obsecure,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        child: Text('   Login   '),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String logInMessage = await loginViewModel.logIn(
                                _usernameController.text,
                                _passwordController.text,
                                context);
                            if (logInMessage == 'Welcome') {
                              removeNavigatTo(context, HomePage());
                            }

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                showCloseIcon: true,
                                backgroundColor: logInMessage != 'Welcome'
                                    ? Colors.red
                                    : Colors.green,
                                content: Text('$logInMessage')));
                          }
                        }),
                    SizedBox(
                      height: 50,
                    ),
                    Text('Do not have an account ?',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400)),
                    TextButton(
                        onPressed: () {
                          {
                            pushNavigateTo(context, SinginScreen());
                          }
                        },
                        child: Text(' sing in ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700)))
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
