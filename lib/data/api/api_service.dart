import 'dart:convert';
import 'package:flutter_restaurant/data/model/restaurant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';

  static const String errorMessage = 'Failed to load data';

  Future<ListRestaurantResult> getList(http.Client client) async {
    final response = await client.get(Uri.parse("${baseUrl}list"));
    if (response.statusCode == 200) {
      return ListRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(errorMessage);
    }
  }

  Future<DetailRestaurantResult> getDetail(http.Client client, String id) async {
    final response = await client.get(Uri.parse("${baseUrl}detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(errorMessage);
    }
  }

  Future<ListRestaurantResult> getSearch(String query) async {
    final response = await http.get(Uri.parse("${baseUrl}search?q=$query"));
    if (response.statusCode == 200) {
      return ListRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(errorMessage);
    }
  }
}
