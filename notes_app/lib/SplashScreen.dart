import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/main.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
  }

class _SplashScreenState extends State<SplashScreen>
  with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage())
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.greenAccent],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft
          )
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('lib/images/logoinotes.jpg'
              ),
            ),
            SizedBox(height: 7),
            Text('Welcome !',
            style: TextStyle(color: Colors.redAccent, fontSize: 35),
            )
          ],
        ),
      ),
    );
  }
}


