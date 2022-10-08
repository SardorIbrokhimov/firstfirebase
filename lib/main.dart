import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstfirebase/pages/add_post.dart';
import 'package:firstfirebase/pages/home.dart';
import 'package:firstfirebase/pages/sign_in.dart';
import 'package:firstfirebase/pages/sign_up.dart';
import 'package:firstfirebase/services/google_sign_in.dart';
import 'package:firstfirebase/services/preference.dart';
import 'package:firstfirebase/widgets/widget_log_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  Widget _startPage() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Preference.saveUserId(snapshot.data!.uid);
          return HomePage();
        } else {
          //Preference.deleteUserId();
          return SignIn();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _startPage(),
        routes: {
          SignUp.id: (context) => SignUp(),
          HomePage.id: (context) => HomePage(),
          SignIn.id: (context) => SignIn(),
          LogInWidget.id: (context) => LogInWidget(),
          AddPostPage.id: (context) => AddPostPage(),
        },
      ));
}
