import 'dart:convert';
import 'dart:io';
import 'package:favorite_movie/models/favoritemovie.dart';
import 'package:http/http.dart' as http;

abstract class Recomended {
  Future getrecomended();
}

class RecomendedIml implements Recomended {
  
  @override
  Future<FavoriteMovie> getrecomended() async {
    var response = await http
        .get('https://video-ws-chfmsoli4q-ew.a.run.app/video-ws/recomended', headers: {
      'token': 'irrelevant',
    });

    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return FavoriteMovie.fromJson(json.decode(response.body));
      } catch (e) {
        print(e);
      }
    } else {
      throw HttpException('Error');
    }
  }
}
