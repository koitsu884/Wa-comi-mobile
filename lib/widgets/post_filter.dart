import 'package:flutter/material.dart';

class PostFilter extends StatefulWidget {
  @override
  _PostFilterState createState() => _PostFilterState();
}

class _PostFilterState extends State<PostFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Center(
          child: Text(
        'Filter here',
      )),
    );
  }
}
