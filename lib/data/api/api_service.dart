import 'dart:convert';
import 'package:flutter_restaurant/data/model/restaurant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  static const String _errorMessage = 'Failed to load data';

  Future<ListRestaurantResult> getList() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return ListRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_errorMessage);
    }
  }

  Future<DetailRestaurantResult> getDetail(String id) async {
    final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_errorMessage);
    }
  }

  Future<ListRestaurantResult> getSearch(String query) async {
    final response = await http.get(Uri.parse("${_baseUrl}search?q=$query"));
    if (response.statusCode == 200) {
      return ListRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_errorMessage);
    }
  }
}
