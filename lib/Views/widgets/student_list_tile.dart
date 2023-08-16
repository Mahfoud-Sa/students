import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:students/Models/user.dart';
import 'package:students/Views/personal_detailes_page.dart';
import 'package:students/utiles/navigations_utiles.dart';

class StudentListTile extends StatelessWidget {
  final User user;
  const StudentListTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset("assets/images/student_image.jpg"),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName.toString(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    user.userName.toString(),
                    style: TextStyle(color: Colors.grey[600]),
                  )
                ],
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffeeeeee)),
                borderRadius: BorderRadius.circular(50)),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              onPressed: () {
                pushNavigateTo(
                    context,
                    PersonalDetailes(
                      user: user,
                    ));
              },
              child: Text("Detailes"),
            ),
          )
        ],
      ),
    );
  }
}
