import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:wacomi/models/post.dart';
import 'package:wacomi/providers/post_list.dart';
import 'package:wacomi/widgets/post_form.dart';

class AddPostScreen extends StatefulWidget {
  final bool editMode;
  AddPostScreen({this.editMode = false});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Future<void> handleSubmit(dynamic formData) async {
    if (widget.editMode) {
      print("Edit mode");
    } else {
      await Provider.of<PostList>(context).addPost(
        Post(
          title: formData['title'].trim(),
          content: formData['content'].trim(),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<PostList>(
        builder: (ctx, postListData, _) => LoadingOverlay(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: PostForm(
                    handleSubmit: handleSubmit,
                    editMode: widget.editMode,
                  ),
                ),
              ),
            ),
            isLoading: postListData.isLoading),
      ),
    );
  }
}
