import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:wacomi/constants.dart';
import 'package:wacomi/exceptions/auth_exception.dart';
import 'package:wacomi/helpers/client.dart';
import 'package:wacomi/exceptions/http_exception.dart';
import 'package:wacomi/models/post.dart';
import 'package:http/http.dart' as http;

class PostList with ChangeNotifier {
  PostList(this.authToken, this.userId);

  final String authToken;
  final int userId;

  List<Post> _posts = [];
  bool _loading = false;
  int _currentPage = 1;
  bool _finished = false;

  List<Post> get posts => [..._posts];
  int get itemCount => _posts.length;
  bool get isLoading => _loading;

  bool get finished => _finished;

  Future<void> fetchItems() async {
    //http get all (Maybe with filter.. such as category?)
    var url = kApiUrl + 'posts?page=$_currentPage';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }

      var nextLink = extractedData['links']['next'];
      if (nextLink == null) {
        _finished = true;
      } else {
        _currentPage++;
      }

      final List<Post> loadedPosts = [];
      extractedData['data'].forEach((postData) {
        // print(postData);
        loadedPosts.add(Post.fromJson(postData));
      });

      _posts.addAll(loadedPosts);
    } catch (error) {
      print(error);
      throw HttpException('投稿一覧の取得に失敗しました');
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> init() async {
    _posts = [];
    _loading = false;
    _currentPage = 1;
    _finished = false;
    await fetchItems();
  }

  Future<void> loadMore() async {
    if (_finished || _loading) return;
    _loading = true;
    notifyListeners();
    await fetchItems();
  }

  Future<void> addPost(Post newPost) async {
    if (userId == null) {
      throw AuthException("ログインしていません");
    }

    _loading = true;
    notifyListeners();

    var url = kApiUrl + 'users/$userId/posts';
    print(url);

    try {
      final response = await Client.httpPost(
        url,
        {'title': newPost.title, 'content': newPost.content},
        authToken,
      );

      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        print("WTF");
        return;
      }
      print(extractedData);

      await init();
      // _loading = false;
      // notifyListeners();

      //TODO: var createdPost =
      // _posts.add(createdPost);
      // or fetch...? <= maybe better in case another user also posted
      // init();
      //
    } catch (error) {
      print(error);
      _loading = false;
      notifyListeners();
      throw HttpException('投稿一覧の取得に失敗しました');
    }
  }
}
