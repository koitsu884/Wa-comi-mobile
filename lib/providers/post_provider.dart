import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:wacomi/constants.dart';
import 'package:wacomi/exceptions/http_exception.dart';
import 'package:wacomi/models/post.dart';
import 'package:http/http.dart' as http;

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  bool _loading = false;

  List<Post> get posts => [..._posts];

  int get itemCount {
    return _posts.length;
  }

  Future<void> fetchItems() async {
    //http get all (Maybe with filter.. such as category?)
    var url = kApiUrl + 'posts';
    print(url);
    _loading = true;
    // notifyListeners();

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      print(extractedData);
      if (extractedData == null) {
        return;
      }

      final List<Post> loadedPosts = [];
      extractedData.forEach((postData) {
        loadedPosts.add(Post(
          id: postData['id'],
          user_id: postData['user_id'],
          title: postData['title'],
          content: postData['content'],
          image: postData['image'],
          comment_count: 0,
        ));
      });

      _posts = loadedPosts;
      notifyListeners();
    } catch (error) {
      print(error);
      throw HttpException('投稿一覧の取得に失敗しました');
    }
    _loading = false;
    notifyListeners();
  }

  void addItem(Post newPost) {
    //http post here
    //when success...
    //fetch all list (in case someone also added while adding)
    notifyListeners();
  }

  void removeItem(int id) {
    //http delete here
    //when success...
    //fetch all list (in case someone also added while adding)
    notifyListeners();
  }
}
