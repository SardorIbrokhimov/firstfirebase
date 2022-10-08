import 'package:firstfirebase/model/post.dart';
import 'package:firstfirebase/pages/add_post.dart';
import 'package:firstfirebase/services/preference.dart';
import 'package:firstfirebase/services/realtime.dart';
import 'package:flutter/material.dart';

import '../services/auth_firebase.dart';

class HomePage extends StatefulWidget {
  static const String id = "home";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> item = [];

  @override
  void initState() {
    super.initState();

    _apiGetPosts();
  }

  _apiGetPosts() async {
    String? userId = await Preference.getUserId();
    RTDB.getPosts(userId!).then((posts) => {
          setState(() {
            item.addAll(posts);
          }),
          print("Posts:${item.length}"),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("All Posts"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                AuthService.signout(context);
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
            itemCount: item.length,
            itemBuilder: (ctx, i) {
              return itemOfList(item[i]);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPostPage()),
          );
        },
      ),
    );
  }

  Widget itemOfList(Post post) {
    return Container(
      padding: EdgeInsets.only(left: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                post.surname,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                post.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            post.content,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            post.date,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
