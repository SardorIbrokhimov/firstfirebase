import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstfirebase/services/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInWidget extends StatefulWidget {
  static const String id = "log";

  const LogInWidget({Key? key}) : super(key: key);

  @override
  State<LogInWidget> createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logged In"),
        centerTitle: true,
        actions: [
          GestureDetector(child:  Text("Log out") ,onTap: (){
            final provider=Provider.of<GoogleSignInProvider>(context,listen: false);

          //  provider.logout();
          },)


        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL!),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Name: ${user!.displayName}",
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Email: ${user!.email}",
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
