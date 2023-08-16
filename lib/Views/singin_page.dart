import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/ViewModels/login_view_model.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

class SinginScreen extends StatefulWidget {
  @override
  _SinginScreenState createState() => _SinginScreenState();
}

class _SinginScreenState extends State<SinginScreen> {
  final passNotifier = ValueNotifier<PasswordStrength?>(null);
  final _formKey = GlobalKey<FormState>();

  final _FnameController = TextEditingController();
  final _SnameController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  DateTime? birthDay = DateTime(2000);
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  var gender = 1;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 300),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back)),
            ),
            const Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text('Sing in With your Informatchion',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('Peronal Details'),
                    ),
                    Divider(
                      height: 5,
                      thickness: 2,
                    ),

                    //_FnameController
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      width: 250,
                      child: TextFormField(
                        controller: _FnameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your First Name';
                          }
                          return null;
                        },
                      ),
                    ),

                    //_SnameController
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      width: 150,
                      child: TextFormField(
                        controller: _SnameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your Last Name';
                          }
                          return null;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('Address'),
                    ),

                    //Address
                    Row(
                      children: [
                        //_countryController
                        Container(
                          padding: EdgeInsets.only(left: 25),
                          width: 150,
                          child: TextFormField(
                            controller: _countryController,
                            decoration: InputDecoration(
                              labelText: 'Countery',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Country';
                              }
                              return null;
                            },
                          ),
                        ),

                        //_cityController
                        Container(
                          padding: EdgeInsets.only(left: 25),
                          width: 150,
                          child: TextFormField(
                            controller: _cityController,
                            decoration: InputDecoration(
                              labelText: 'City',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your city';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),

                    //_neighborhoodController
                    Container(
                      padding: EdgeInsets.only(left: 25),
                      width: 250,
                      child: TextFormField(
                        controller: _neighborhoodController,
                        decoration: InputDecoration(
                          labelText: 'Neighborhood',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your Neighborhood';
                          }
                          return null;
                        },
                      ),
                    ),

                    //Birthday
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Birth day"),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton.icon(
                                      icon: Icon(Icons.calendar_today),
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: birthDay!,
                                                firstDate: DateTime(1899),
                                                lastDate: DateTime.now())
                                            .then((value) {
                                          setState(() {
                                            birthDay = value;
                                          });
                                        });
                                      },
                                      label: Text('Change')),
                                  Text(birthDay.toString().substring(0, 10)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Gender
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Select Gender'),
                          Row(
                            children: [
                              RadioMenuButton(
                                  value: 1,
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value!;
                                    });
                                  },
                                  child: Text("Mail")),
                              RadioMenuButton(
                                  value: 0,
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value!;
                                    });
                                  },
                                  child: Text("Female")),
                            ],
                          ),
                        ],
                      ),
                    ),

                    //User Name
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('Account Details'),
                    ),
                    Divider(
                      height: 5,
                      thickness: 2,
                    ),

                    ////User Name
                    Container(
                      padding: EdgeInsets.only(left: 25),
                      width: 250,
                      child: TextFormField(
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
                    ),

                    //Password
                    Container(
                      padding: EdgeInsets.only(left: 25),
                      width: 250,
                      child: TextFormField(
                        onChanged: (value) {
                          passNotifier.value =
                              PasswordStrength.calculate(text: value);
                        },
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
                    ),

                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        width: 250,
                        child: PasswordStrengthChecker(
                          strength: passNotifier,
                        )),

                    //rePassword
                    Container(
                      padding: EdgeInsets.only(left: 25),
                      width: 250,
                      child: TextFormField(
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
                    ),
                    SizedBox(height: 24.0),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                child: Text(' sing in '),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String loginState = await loginVewModel.Singin(
                        _FnameController.text,
                        _SnameController.text,
                        _countryController.text,
                        _cityController.text,
                        _neighborhoodController.text,
                        birthDay!,
                        gender,
                        _usernameController.text,
                        _passwordController.text);
                    if (loginState == "Singin Successfully") {
                      Navigator.of(context).pop();
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        showCloseIcon: true,
                        backgroundColor: loginState == "Singin Successfully"
                            ? Colors.green
                            : Colors.red,
                        content: Text('$loginState')));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
