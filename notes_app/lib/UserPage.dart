import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('iNotes'),
    ),
    body: Image.asset('lib/images/logoinotes.png'
    ),
  );
}

