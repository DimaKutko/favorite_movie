import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:favorite_movie/Models/movie_info.dart';

abstract class MovieService {
  Future<Movie> getMovieInfo();
}

class MovieServiceImpl implements MovieService {
  String name, _name;
  @override
  Future<Movie> getMovieInfo() async {
    
    print("$name 1");
    _name = name;
    print("$_name 2");
    Uri uri =
        Uri.http('www.omdbapi.com', '', {'t': '$_name', 'apikey': 'fdb692c9'});
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
