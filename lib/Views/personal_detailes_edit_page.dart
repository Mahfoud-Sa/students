import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:provider/provider.dart';
import 'package:students/Models/user.dart';
import 'package:students/ViewModels/users_view_model.dart';
import 'package:students/Views/users_page.dart';
import 'package:students/Views/widgets/student_feild.dart';
import 'package:students/utiles/navigations_utiles.dart';

class PersonalDetailesEdit extends StatefulWidget {
  final User user;
  PersonalDetailesEdit({super.key, required this.user});

  @override
  State<PersonalDetailesEdit> createState() => _PersonalDetailesEditState();
}

class _PersonalDetailesEditState extends State<PersonalDetailesEdit> {
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

  final passCont = TextEditingController();

  var gender = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _FnameController.text = widget.user.fullName.toString();
    _SnameController.text = widget.user.lastName.toString();
    _countryController.text = widget.user.country.toString();
    _cityController.text = widget.user.city.toString();
    _neighborhoodController.text = widget.user.neighborhood.toString();
    _usernameController.text = widget.user.userName.toString();

    gender = widget.user.gender!;
    birthDay = widget.user.borthDay!;
  }

  @override
  Widget build(BuildContext context) {
    var userViewModel = Provider.of<UsersViewModel>(context);

    Future OpenDialonge() {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete Account"),
            //icon: Icon(Icons.dangerous),

            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter Your Password To converm",
                  style: TextStyle(fontSize: 12),
                ),
                TextFormField(
                  obscureText: true,
                  controller: passCont,
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    User upatedUser = User(
                        id: widget.user.id,
                        fullName: _FnameController.text,
                        lastName: _SnameController.text,
                        country: _countryController.text,
                        city: _cityController.text,
                        neighborhood: _neighborhoodController.text,
                        borthDay: birthDay,
                        gender: gender,
                        userName: _usernameController.text,
                        password: _passwordController.text);
                    String state = await userViewModel.updateUser(
                        widget.user.id!, upatedUser);
                    if (state == "Done") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          showCloseIcon: true,
                          backgroundColor: Colors.red,
                          content: Text('Done')));
                      removeNavigatTo(context, UsersPage());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          showCloseIcon: true,
                          backgroundColor: Colors.red,
                          content: Text('Password Error')));
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Converm"))
            ],
          );
        },
      );
    }

    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ListView(
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              AssetImage("assets/images/student_image.jpg"))),
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 4, color: Colors.white),
                          color: Colors.blue),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 30,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "CANCEL",
                    style: TextStyle(
                        fontSize: 15, letterSpacing: 2, color: Colors.black),
                  ),
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
              OutlinedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      OpenDialonge();
                    }
                  },
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                        fontSize: 15, letterSpacing: 2, color: Colors.white),
                  ),
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
            ],
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    ));
  }
}
