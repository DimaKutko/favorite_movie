class Movie {
  final String title;
  final String year;
  final String id;
  final String poster;

  Movie({this.title, this.year, this.id, this.poster});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      year: json['Year'],
      id: json['imdbID'],
      poster: json['Poster'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'year': year,
      'imdbid': id,
      'poster': poster,
    };
  }
}
