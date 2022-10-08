import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstfirebase/pages/home.dart';
import 'package:firstfirebase/pages/sign_up.dart';
import 'package:firstfirebase/services/auth_firebase.dart';
import 'package:firstfirebase/services/google_sign_in.dart';
import 'package:firstfirebase/services/preference.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  static const String id = "in";

  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final userPost = GlobalKey<FormState>();

  late String email, password;

  bool on = true;

  int count = 0;

  Icon close = Icon(Icons.visibility_off);
  Icon open = Icon(Icons.visibility);

  var emailcont = TextEditingController();
  var passwordcont = TextEditingController();

  _doSignIn() async {
    String email = emailcont.text.toString().trim();
    String password = passwordcont.text.toString().trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      await AuthService.signInUser(context, email, password)
          .then((firebaseUser) => {
                _getFirebaseUser(firebaseUser),
              });
    }
  }

  _getFirebaseUser(User firebaseUser) async {
    if (firebaseUser != null) {
      await Preference.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title:   Text(
          "Log In",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: userPost,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),


                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: emailcont,
                  onSaved: (input) => email = input!,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                //password
                TextFormField(
                  controller: passwordcont,
                  validator: (input) {
                    if (input!.length >= 8) {
                      return null;
                    } else {
                      return "Invalid password";
                    }
                  },
                  onSaved: (input) => password = input!,
                  obscureText: on,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        count++;
                        setState(() {
                          if (count.isEven) {
                            on = true;
                          } else {
                            on = false;
                          }
                        });

                        print(count);
                      },
                      icon: count.isOdd ? close : open,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),

                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "By singing up you accept the ",
                      style: TextStyle(fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "term of service",
                        style: TextStyle(fontSize: 15, color: Colors.deepOrangeAccent),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "and",
                      style: TextStyle(fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(fontSize: 15, color: Colors.deepOrangeAccent),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: TextButton(
                      onPressed: _doSignIn,
                      child: Text(
                        "Sign In",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(""),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, SignUp.id);
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.deepOrangeAccent),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: TextButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.google,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sign Up with Google",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
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
