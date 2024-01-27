import 'package:flutter/material.dart';
import 'package:notes_app/UserPage.dart';
import 'package:notes_app/registration.dart';
import 'SplashScreen.dart';
import 'login.dart';

void main() {
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
      home: const SplashScreen(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Home'),
      backgroundColor: Colors.greenAccent.shade700,
    ),
    drawer: const NavigationDrawer(),
  );
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

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
          children: const[
            CircleAvatar(
              radius: 52,
              backgroundImage: AssetImage('lib/images/logoinotes.jpg'
              ),
            ),
            SizedBox(height: 12),
            Text(
              'iNotes',
              style: TextStyle(fontSize: 28, color: Colors.white

              ),
            )
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





