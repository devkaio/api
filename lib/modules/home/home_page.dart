import 'package:api/models/post.dart';
import 'package:flutter/material.dart';

import '../../post_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Post>> futurePost;

  @override
  void initState() {
    futurePost = getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Post> data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(data[index].title),
                    leading: Text('ID: ' + data[index].id.toString()),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
