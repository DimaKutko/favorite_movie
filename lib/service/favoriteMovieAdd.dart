import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class FavoriteAddMovie {
  String id, title, year, poster, label;
  int priority = 0,
      rating = 0,
      timestamp = DateTime.now().millisecondsSinceEpoch;
  bool viewed;

  FavoriteAddMovie(
    this.id,
    this.title,
    this.year,
    this.poster,
    this.label,
    this.priority,
    this.viewed,
    this.rating,
  );

  Future favoriteAddMovie() async {
    String url = 'https://video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos/';
    Map body = {
      'id': '$id',
      'title': '$title',
      'year': '$year',
      'poster': '$poster',
      'label': '$label',
      'priority': priority,
      'viewed': viewed,
      'rating': rating,
      'timestamp': timestamp,
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
