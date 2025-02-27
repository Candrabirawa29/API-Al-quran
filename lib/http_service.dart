import 'dart:convert';
import 'package:http/http.dart';
import 'post_model.dart';

class HttpService {
  final String postsURL = "https://quran-api.santrikoding.com/api/surah";

  Future<List<Post>> getPosts() async {
    Response res = await get(Uri.parse(postsURL));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();
      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<Post> getDetail(int nomor) async {
    Response res = await get(Uri.parse("$postsURL/$nomor"));
    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      return Post.fromJson(body);
    } else {
      throw "Unable to retrieve detail.";
    }
  }
}