import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:favorite_movie/Models/movie_info.dart';

abstract class MovieService{
  Future<Movie> getMovieInfo();
}

class MovieServiceImpl implements MovieService {

  @override
  Future<Movie> getMovieInfo() async{
    Uri uri = Uri.http('www.omdbapi.com','', {
      't': 'titanic',
      'apikey': 'fdb692c9'
    });
    http.Response response = await http.get(uri);
    if (response.statusCode >= 200 && response.statusCode < 300 ){
      
      try {
        return Movie.fromJson(json.decode(response.body));
        
      }catch(e){
        print(e);
      }
      
    }else{
      throw HttpException('Error');
    }
  }
}