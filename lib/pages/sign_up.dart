import 'package:firstfirebase/pages/home.dart';
import 'package:firstfirebase/pages/sign_in.dart';
import 'package:firstfirebase/services/auth_firebase.dart';
import 'package:firstfirebase/services/preference.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  static const String id = "up";

  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int count = 0;
  int count2 = 0;
  late String name, email, password;

  final userPost = GlobalKey<FormState>();

  var namecont = TextEditingController();
  var emailcont = TextEditingController();
  var passwordcont = TextEditingController();

  _doSignUp() {
    String name = namecont.text.toString().trim();
    String email = emailcont.text.toString().trim();
    String password = passwordcont.text.toString().trim();

    AuthService.signUpUser(context, name, email, password)
        .then((firebaseUser) => {
              _getFirebaseUser(firebaseUser),
            });
  }

  _getFirebaseUser(var firebaseUser) async {
    if (firebaseUser != null) {
      await Preference.saveUserId(firebaseUser.uid);
      print(firebaseUser.displayName);
      Navigator.pushReplacementNamed(context, HomePage.id);
    } else {
      return CircularProgressIndicator();
    }
  }

  Icon open = Icon(Icons.visibility);
  Icon close = Icon(Icons.visibility_off);
  bool on = true;
  bool on2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title:  Text(
          "Creat New Account",
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
                  controller: namecont,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: emailcont,
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
                      onPressed: () {
                        _doSignUp();
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, SignIn.id);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.deepOrangeAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
