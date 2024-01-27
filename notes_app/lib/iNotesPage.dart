import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class iNotesPage extends StatefulWidget {

  @override
  _iNotesPage createState() => _iNotesPage();
}

class _iNotesPage extends State<iNotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Center(
          child: Text('Login Successfully'),
      ),
    );
  }
}
