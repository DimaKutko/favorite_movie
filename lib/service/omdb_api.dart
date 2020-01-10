import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:favorite_movie/Models/movie_info.dart';

abstract class MovieService {
  Future getMovieInfo();
}

class MovieServiceImpl implements MovieService {
  @override
  String namemovie;
  String years;
  MovieServiceImpl(this.namemovie, this.years);

  Future<Movie> getMovieInfo() async {
    Uri uri = Uri.http('www.omdbapi.com', '',
        {'t': '$namemovie', 'apikey': 'fdb692c9', 'y': '$years'});

    http.Response response = await http.get(uri);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return Movie.fromJson(json.decode(response.body));
      } catch (e) {
        print(e);
      }
    } else {
      throw HttpException('Error');
    }
  }
}
