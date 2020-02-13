import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class PutEditMovie {
  String id, title, year, poster, label;
  int priority = 0,
      rating = 0,
      timestamp;
  bool viewed;

  PutEditMovie(
    this.id,
    this.title,
    this.year,
    this.poster,
    this.label,
    this.priority,
    this.viewed,
    this.rating,
    this.timestamp,
  );

  Future putEditMovie() async {
    String url = 'https://video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos/$id';
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

    var response = await http.put(url,
        headers: {
          'token': 'dima',
          // 'Content-Type': 'application/json',
        },
        body: data);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        print('Edit movie $title to favorite Movie');
      } catch (e) {
        print(e);
        print('ERROR !!!');
      }
    } else {
      throw HttpException('Error');
    }
  }
}
