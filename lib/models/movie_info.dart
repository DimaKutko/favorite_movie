class Movie {
  final String title;
  final String year;
  final String imdbid;
  final String poster;

  Movie({
    this.title,
    this.year,
    this.imdbid,
    this.poster,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      year: json['Year'],
      imdbid: json['imdbID'],
      poster: json['Poster'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'year': year,
      'imdbid': imdbid,
      'poster': poster,
    };
  }
}
