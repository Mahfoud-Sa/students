import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

pushNavigateTo(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => page),
  );
}

removeNavigatTo(BuildContext context, Widget page) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page), (route) => false);
}
