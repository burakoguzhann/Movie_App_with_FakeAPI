import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_model.dart';

class MovieService {
  Future<List<MovieModel>> getMovies() async {
    final url = Uri.parse('https://www.apirequest.in/movie/api');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> movieList = jsonDecode(response.body);
      return movieList.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
