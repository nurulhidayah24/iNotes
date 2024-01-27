import 'package:flutter/material.dart';
import 'package:notes_app/Comm/comHelper.dart';
import 'package:notes_app/registration.dart';
import 'package:notes_app/Comm/genTextFormField.dart';
import 'Database/DbHelper.dart';
import 'Model/UserModel.dart';
import 'iNotesPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();

}
class _LoginState extends State<Login> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();
  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  login() async {
    String uid = _conUserId.text;
    String upassword = _conPassword.text;

    if(uid.isEmpty) {
      alertDialog(context, "Please Enter User ID !");
    }else if(upassword.isEmpty) {
      alertDialog(context, "Please Enter Password !");
    }else {
      await dbHelper.getloginUser(uid, upassword).then((userData) {
        if(userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => iNotesPage()),
                    (Route<dynamic> route) => false);
          });
        }else {
          alertDialog(context, "User Not Found !");
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Login Fail !");
      });
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_id", user.user_id);
    sp.setString("name", user.name);
    sp.setString("email", user.email);
    sp.setString("password", user.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.greenAccent.shade700,
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10.0),
                Image.asset('lib/images/logoinotes.jpg',
                height: 150.0,
                  width: 150.0,
                ),

                /*    textfield untuk userid*/
                getTextFormField(
                    controller: _conUserId,
                    icon: Icons.person,
                    hintName: 'User ID',
                  isObscureText: false,
                ),
                SizedBox(height: 10.0),

                /*    textfield untuk password*/
                getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                ),

                /*    button untuk login*/
                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: TextButton(
                    child:Text(
                        'Login',
                    style: TextStyle(color: Colors.white),
                    ),
                    onPressed: login,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),

                /*    signup untuk intent*/
                Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Does not have account ?'),
                        TextButton(
                          child: Text('Signup',
                              style: TextStyle(
                                color: Colors.blue,
                              )
                          ),
                          onPressed:(){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Registration()));
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



