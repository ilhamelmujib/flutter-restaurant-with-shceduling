import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_restaurant/data/model/restaurant.dart';
import '../data/api/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  late String id;
  String _message = '';
  String get message => _message;
  late ResultState _state = ResultState.loading;
  ListRestaurantResult get resultList => _listRestaurantResult;
  DetailRestaurantResult get resultDetail => _detailRestaurantResult;
  ResultState get state => _state;

  late ListRestaurantResult _listRestaurantResult;
  late DetailRestaurantResult _detailRestaurantResult;

  RestaurantProvider({required this.apiService}){
    fetchListRestaurant();
  }

  void fetchListRestaurant(){
    _fetchListRestaurant();
  }

  void fetchSearchRestaurant(String query){
    _fetchSearchRestaurant(query);
  }

  Future<dynamic> _fetchListRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final list = await apiService.getList();
      if (list.restaurants!.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listRestaurantResult = list;
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

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final data = await apiService.getDetail(id);
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

  Future<dynamic> _fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final list = await apiService.getSearch(query);
      if (list.restaurants!.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listRestaurantResult = list;
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
