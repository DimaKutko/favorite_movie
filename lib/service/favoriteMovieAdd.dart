import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class FavoriteAddMovie {
  String id;
  String title;
  String year;
  String poster;

  FavoriteAddMovie(
    this.id,
    this.title,
    this.year,
    this.poster,
  );

  Future favoriteAddMovie() async {
    String url = 'https://video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos/';
    Map body = {
      'id': '$id',
      'title': '$title',
      'year': '$year',
      'poster': '$poster',
      'label': 'my film',
      'priority': 1,
      'viewed': false,
      'rating': 10,
      'timestamp': 1575473859,
    };
    var data = json.encode(body);

    var response = await http.post(url,
        headers: {
          'token': 'dima',
         // 'Content-Type': 'application/json',
          //'Host': 'video-ws-chfmsoli4q-ew.a.run.app',
        },
        body: data);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        print('Add movie $title to favorite Movie');
      } catch (e) {
        print(e);
        print('ERROR !!!');
      }
    } else {
      throw HttpException('Error');
    }
  }
}
