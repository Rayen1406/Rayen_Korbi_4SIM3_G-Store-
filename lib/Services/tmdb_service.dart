import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class TMDBService {
  static const String apiKey = "1e37cfc820cd3fd1100e13bcb642f3a0";
  static const String baseUrl = "https://api.themoviedb.org/3";

  static String getImageUrl(String path) {
    return "https://image.tmdb.org/t/p/w500$path";
  }

  // Fetch trending movies with pagination
  static Future<List<Movie>> fetchTrendingMovies(int page) async {
    final url = Uri.parse(
      "$baseUrl/trending/movie/week?api_key=$apiKey&page=$page",
    );

    final response = await http.get(url);

    if (response.statusCode != 200) return [];

    final data = jsonDecode(response.body);

    List results = data["results"];

    return results.map((json) => Movie.fromJson(json)).toList();
  }
}
