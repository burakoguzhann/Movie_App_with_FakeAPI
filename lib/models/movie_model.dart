class MovieModel {
  final String title;
  final String year;
  final String imdbRating;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String plot;
  final String language;
  final String country;
  final String actors; // Düzeltildi!
  final List<String> images;

  MovieModel({
    required this.title,
    required this.year,
    required this.imdbRating,
    required this.images,
    required this.released,
    required this.genre,
    required this.director,
    required this.writer,
    required this.plot,
    required this.language,
    required this.country,
    required this.actors, // Düzeltildi!
    required this.runtime,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'] ?? '',
      year: json['year'] ?? '',
      imdbRating: json['imdbRating'] ?? '',
      images: json['Images'] != null
          ? List<String>.from(json['Images'])
          : [],
      released: json['released'] ?? '',
      runtime: json['runtime'] ?? '',
      genre: json['genre'] ?? '',
      director: json['director'] ?? '',
      writer: json['writer'] ?? '',
      plot: json['plot'] ?? '',
      language: json['language'] ?? '',
      country: json['country'] ?? '',
      actors: json['actors'] ?? '', // Düzeltildi!
    );
  }
}
