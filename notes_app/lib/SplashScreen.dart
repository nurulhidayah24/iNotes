import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/main.dart';


class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

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
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Image.asset(
              'lib/images/logoinotes.png',
              height: 250.0,
              width: 150.0,
              //fit: BoxFit.cover,
              ),
            SizedBox(height: 7),
            Text('Welcome !',
              style: GoogleFonts.pacifico(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold ),
            ),
          ],
        ),
      ),
    );
  }
}


