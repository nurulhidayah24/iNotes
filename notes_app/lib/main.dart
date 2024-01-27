
import 'package:flutter/material.dart';
import 'package:notes_app/Database/DbNotes.dart';
import 'package:notes_app/UserPage.dart';
import 'package:notes_app/registration.dart';
import 'SplashScreen.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotesDatabase.initialiseDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iNotes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home:  SplashScreen(),
    );
  }
}

class HomePage extends StatelessWidget{
  const HomePage ({super.key});


  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Welcome'),
      backgroundColor: Colors.greenAccent.shade700,
    ),
    body: Column(
        children: [
    Padding(padding: const EdgeInsets.all(20),
      child: Text("Your iNotes ",
      style: TextStyle(
        color: Colors.green[700],
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  ),

        SizedBox(
            height: 750,
            width: double.infinity,
            child: AnotherCarousel(
            images: const[
            AssetImage("lib/images/bunga.jpg"),
            AssetImage("lib/images/2.jpg"),
            AssetImage("lib/images/3.jpg"),
            AssetImage("lib/images/4.jpg"),
        ],
        dotSize:6,
        indicatorBgPadding: 5.0,
        ),
        )

        ],
        ),
        drawer: const NavigationDrawer(),
        );

}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),
  );

  Widget buildHeader(BuildContext context) => Material(
    color: Colors.greenAccent.shade700,
    child: InkWell(
      onTap: (){
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute
          (builder: (context) => const UserPage(),
        ));
      },
      child:Container(
        padding: EdgeInsets.only(
          top: 24 + MediaQuery.of(context).padding.top,
          bottom: 24,
        ),
        child: Column(
          children: [
          Image.asset(
            'lib/images/logoinotes.png',
            height: 150.0,
            width: 150.0,
              ),
            const SizedBox(height: 12),


          ],
        ),
      ),
    ),
  );


  Widget buildMenuItems(BuildContext context) => Container(
      padding:const EdgeInsets.all(24),
      child: Wrap(
          runSpacing: 16,
          children:[
            ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Home'),
                onTap: () =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute
                      (builder: (context) => const HomePage(),
                    ))
            ),
            const Divider(color: Colors.black54),
            ListTile(
                leading: const Icon(Icons.app_registration_outlined),
                title: const Text('Registration'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute
                    (builder: (context) => const Registration(),
                  ));
                }
            ),
            const Divider(color: Colors.black54),
            ListTile(
                leading: const Icon(Icons.login_outlined),
                title: const Text('Login'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute
                    (builder: (context) => const Login(),
                  ));
                }
            )
          ]
      )
  );

}