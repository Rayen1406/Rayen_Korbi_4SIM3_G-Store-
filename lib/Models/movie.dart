class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final double vote;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.vote,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? 'No title',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
      vote: (json['vote_average'] as num).toDouble(),
    );
  }
}
