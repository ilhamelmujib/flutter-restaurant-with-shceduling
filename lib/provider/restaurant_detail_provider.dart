import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_restaurant/data/model/restaurant.dart';
import '../data/api/api_service.dart';
import 'package:http/http.dart' as http;

enum ResultState { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  String _message = '';

  String get message => _message;
  late ResultState _state = ResultState.loading;

  DetailRestaurantResult get resultDetail => _detailRestaurantResult;

  ResultState get state => _state;

  late DetailRestaurantResult _detailRestaurantResult;

  RestaurantDetailProvider({required this.apiService});

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final data = await apiService.getDetail(http.Client(), id);
      if (data.restaurant == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurantResult = data;
      }
    } on SocketException catch (_) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No Internet Connection';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
