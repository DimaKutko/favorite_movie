import 'dart:io';
import 'package:http/http.dart' as http;

class FavoriteMovieDel {
  String idmovie, token;
  FavoriteMovieDel(this.idmovie, this.token);

  Future favoriteMovieDel() async {
    var response = await http.delete(
        'https://video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos/$idmovie',
        headers: {
          'token': '$token',
        });
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        print('Delete movie id $idmovie');
      } catch (e) {
        print(e);
        print('ERROR !!!');
      }
    } else {
      throw HttpException('Error');
    }
  }
}
