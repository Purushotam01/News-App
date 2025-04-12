import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsProvider with ChangeNotifier {
  List<Article> _articles = [];
  bool _isLoading = false;
  String _error = '';

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String get error => _error;

  static const String _apiKey = '95d37bde7ea0d93cb26be57b3f498e8b';
  static const String _baseUrl = 'https://gnews.io/api/v4/search';

  Future<void> fetchNews({String query = 'example'}) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final queryValue = query.trim().isEmpty ? 'news' : query.trim();
      final encodedQuery = Uri.encodeComponent(queryValue);

      final url =
          '$_baseUrl?q=$encodedQuery&lang=en&country=us&max=10&apikey=$_apiKey';

      debugPrint('🔍 Fetching from: $url');

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['articles'] != null && data['articles'] is List) {
          _articles = (data['articles'] as List)
              .map((json) => Article.fromJson(json))
              .toList();
        } else {
          _articles = [];
          _error = 'No articles found.';
        }
      } else {
        _error = 'Failed to load news. Status code: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error fetching news: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
  