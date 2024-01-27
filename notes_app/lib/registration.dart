import 'package:flutter/material.dart';
import 'package:notes_app/Comm/comHelper.dart';
import 'package:notes_app/Model/UserModel.dart';
import 'package:notes_app/login.dart';
import 'package:notes_app/Comm/genTextFormField.dart';
import 'Database/DbHelper.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();
  final _conConfirmPassword = TextEditingController();
  final _conEmail = TextEditingController();
  final _conname = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async {
    String uid = _conUserId.text;
    String uname = _conname.text;
    String uemail = _conEmail.text;
    String upassword = _conPassword.text;
    String ucpassword = _conConfirmPassword.text;

    if(_formKey.currentState!.validate()) {
      if(upassword!=ucpassword) {
        alertDialog(context, 'Password Mismatch');
      }else {
        _formKey.currentState?.save();

        UserModel uModel = UserModel(uid, uname, uemail, upassword);
        await dbHelper.saveData(uModel).then((userData) {
          alertDialog(context, "Successfully Registered !");

          Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
        }).catchError((error) {
          print(error);
          alertDialog(context, "Error to insert data !");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.greenAccent.shade700,
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10.0),
                  Image.asset('lib/images/logoinotes.png',
                    height: 250.0,
                    width: 150.0,
                  ),

                  /*    textfield untuk userid*/
                  getTextFormField(
                    controller: _conUserId,
                    icon: Icons.person,
                    hintName: 'User ID',
                    isObsecureText: false,
                  ),
                  SizedBox(height: 10.0),

                  /*    textfield untuk name*/
                  getTextFormField(
                    controller: _conname,
                    icon: Icons.person_outline,
                    inputType: TextInputType.name,
                    hintName: 'Name',
                    isObsecureText: false,
                  ),
                  SizedBox(height: 10.0),

                  /*    textfield untuk email*/
                  getTextFormField(
                    controller: _conEmail,
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    hintName: 'Email',
                    isObsecureText: false,
                  ),
                  SizedBox(height: 10.0),

                  /*    textfield untuk password*/
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObsecureText: true,
                  ),

                  SizedBox(height: 10.0),

                  /*    textfield untuk confirm password*/
                  getTextFormField(
                    controller: _conConfirmPassword,
                    icon: Icons.lock_outline,
                    hintName: 'Confirm Password',
                    isObsecureText: true,
                  ),

                  /*    button untuk login*/
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: TextButton(
                      child:Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: signUp,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

