import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:favorite_movie/Models/movie_info.dart';

abstract class MovieService {
  Future getMovieInfo();
}

class MovieServiceImpl implements MovieService {
  String namemovie;
  MovieServiceImpl(this.namemovie);

  Future<Movie> getMovieInfo() async {
    Uri uri = Uri.http(
        'www.omdbapi.com', '', {'t': '$namemovie', 'apikey': 'fdb692c9'});

    http.Response response = await http.get(uri);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return Movie.fromJson(json.decode(response.body));
      } catch (e) {
        print(e);
        print('ERROR !!!');
      }
    } else {
      throw HttpException('Error');
    }
  }
}
