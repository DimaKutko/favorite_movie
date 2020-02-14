import 'package:favorite_movie/models/favoritemovie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListMovie {
  String token;
  ListMovie(this.token);
  Future<List<FavoriteMovie>> getFavoriteMovie() async {
    var response = await http.get(
        'https://video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos',
        headers: {
          'token': '$token',
        });

    var favoritemovie = List<FavoriteMovie>();

    if (response.statusCode == 200) {
      var fm = json.decode(response.body);
      for (var fm in fm) {
        favoritemovie.add(FavoriteMovie.fromJson(fm));
      }
    }
    return favoritemovie;
  }
}
