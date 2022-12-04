import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:superestaurants/api/Constants.dart';
import 'package:superestaurants/api/post/post.dart';

class PostService {
  static Future<List<Post>> listPost() async {
    final response = await http.get(Uri.parse(Paths().restaurants()));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((e) => Post.fromJson(e))
          .toList();
    } else {
      throw Exception('Error de comsumo de API');
    }
  }
}
