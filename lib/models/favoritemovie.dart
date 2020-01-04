class FavoriteMovie {
  String id;
  String title;
  String year;
  String poster;
  String label;
  int priority;
  bool viewed;
  int rating;
  int timestamp;

  FavoriteMovie(this.id, this.title, this.year, this.poster, this.label,
      this.priority, this.viewed, this.rating, this.timestamp);

  FavoriteMovie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    year = json['year'];
    poster = json['poster'];
    label = json['label'];
    priority = json['priority'] as int;
    viewed = json['viewed'] as bool;
    rating = json['rating'] as int;
    timestamp = json['timestamp'] as int;
  }
}
