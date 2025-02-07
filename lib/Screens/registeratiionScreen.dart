import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_rider/Screens/loginScreen.dart';
import 'package:uber_rider/Screens/mainscreen.dart';
import 'package:uber_rider/Widgets/progressDialog.dart';
import 'package:uber_rider/main.dart';

class RegisteratiionScreen extends StatelessWidget {

  static const String idScreen = "register";
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              Image(
                image: AssetImage("images/logo.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),

              SizedBox(height: 1.0,),
              Text(
                "Register as a Rider",
                style: TextStyle(fontSize: 24.0,fontFamily: "Bolt Regular"),
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone no.",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 10.0,),
                    RaisedButton(
                      color: Colors.yellow,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(fontSize: 18.0,fontFamily: "Bolt Regular"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed:()
                      {
                        if(nameTextEditingController.text.length > 4){
                          displayToastMessage("name must be atleast 3 characters", context);
                        }
                        else if(!emailTextEditingController.text.contains("@")) {
                          displayToastMessage("email is not in proper format", context);
                        }
                        else if(phoneTextEditingController.text.isEmpty) {
                          displayToastMessage("Please Enter A phone Number", context);
                        }
                        else if(passwordTextEditingController.text.length < 6){
                          displayToastMessage("Password must be longer than 6 Characters", context);
                        }
                        else {
                          registerNewUser(context);
                        }

                      },
                    ),

                  ],
                ),
              ),
              FlatButton(
                onPressed: ()
                {
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Already have an Account ? Login Here",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async
  {

    showDialog(context: context, barrierDismissible: false,builder: (BuildContext context){
      ProgressDialog(message: "Registering, Please wait...",);
    });

    final User firebaseUser = (await _firebaseAuth.createUserWithEmailAndPassword(email: emailTextEditingController.text, password: passwordTextEditingController.text).catchError((err){
      Navigator.pop(context);
      displayToastMessage("Error :" + err.toString(), context);
      })).user;

      if(firebaseUser != null){

        Map userDataMap = {
          "name": nameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.trim(),
          "phone": phoneTextEditingController.text.trim(),
        };
        userRef.child(firebaseUser.uid).set(userDataMap);
        displayToastMessage("Congratualions, your account has been created", context);

        Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
      }
      else {
        Navigator.pop(context);
        displayToastMessage("New User Account has not been Created", context);
      }
  }


}

displayToastMessage(String message,BuildContext context){
  Fluttertoast.showToast(msg: message);

}