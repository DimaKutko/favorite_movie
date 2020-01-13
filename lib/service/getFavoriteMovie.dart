import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:favorite_movie/models/favoritemovie.dart';
import 'package:http/http.dart' as http;

abstract class GetFavoriteMovie {
  Future<List<FavoriteMovie>> getFavoriteMovie();
}

class GetFavoriteMovieImpl implements GetFavoriteMovie {
  List<FavoriteMovie> _favoritemovie = List<FavoriteMovie>();

  Future<List<FavoriteMovie>> getFavoriteMovie() async {
    var response = await http.get(
        'https://video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos',
        headers: {
          'token': 'dima',
        });

    List<FavoriteMovie> favoritemovie = List<FavoriteMovie>();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var fm = json.decode(response.body);
      for (var fm in fm) {
        favoritemovie.add(FavoriteMovie.fromJson(fm));
        
      }
      
      /* favoritemovie.then((value) {
      
        _favoritemovie.addAll(value);
      
    }); */

      return favoritemovie;
    } else {
      throw HttpException('TBD');
    }
  }
  
}

/* if (response.statusCode == 200) {
      var fm = json.decode(response.body);
      for (var fm in fm) {
        favoritemovie.add(FavoriteMovie.fromJson(fm));
      }
    } */

/* Map<String, dynamic> decodedJson = jsonDecode(json);
        decodedJson.forEach((key, value) {
          // List<Map<String, dynamic>> decodedList = value as List<Map<String, dynamic>>;
          value.forEach((listItem) {
            movie.add(FavoriteMovie.fromJson(listItem as Map<String, dynamic>));}
          }); */

/* Map<String, dynamic> decodedJson = jsonDecode(json);
        decodedJson.forEach((key, value) {
          value.forEach((listItem) {
            movie.add(FavoriteMovie.fromJson(listItem as Map<String, dynamic>));
          });
        }); */
