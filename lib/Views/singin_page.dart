import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/ViewModels/login_view_model.dart';

class SinginScreen extends StatefulWidget {
  @override
  _SinginScreenState createState() => _SinginScreenState();
}

class _SinginScreenState extends State<SinginScreen> {
  //SinginVM data = SinginVM();
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginVewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('sing in'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Image.asset('assets/images/login_image.jpg'),
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
                    TextFormField(
                      controller: _rePasswordController,
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
                        child: Text('sing in'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String loginState = await loginVewModel.Singin(
                                _usernameController.text,
                                _passwordController.text);
                            if (loginState == "Singin Successfully") {
                              Navigator.of(context).pop();
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                showCloseIcon: true,
                                backgroundColor:
                                    loginState == "Singin Successfully"
                                        ? Colors.green
                                        : Colors.red,
                                content: Text('$loginState')));
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
