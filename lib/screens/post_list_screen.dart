import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wacomi/providers/auth.dart';
import 'package:wacomi/providers/post_list.dart';
import 'package:wacomi/screens/add_post_screen.dart';

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

  @override
  void initState() {
    super.initState();
    Provider.of<PostList>(context, listen: false).init();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Provider.of<PostList>(context, listen: false).loadMore();
      }
    });
  }

  @override
  dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _loader() {
    return Align(
      child: Container(
        width: 70,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      alignment: FractionalOffset.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, auth, _) => Scaffold(
        appBar: AppBar(
          title: Text(
            '投稿一覧',
          ),
        ),
        floatingActionButton: auth.isAuth
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (ctx) => AddPostScreen(),
                  ));
                },
                child: Icon(Icons.add),
              )
            : null,
        body: Consumer<PostList>(
          builder: (ctx, postListData, _) => Stack(
            children: <Widget>[
              ListView.builder(
                controller: _scrollController,
                itemCount: postListData.posts.length,
                padding: EdgeInsets.only(bottom: 50.0),
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(
                      postListData.posts[index].title,
                    ),
                  );
                },
              ),
              postListData.isLoading
                  ? _loader()
                  : SizedBox(
                      height: 0.0,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
