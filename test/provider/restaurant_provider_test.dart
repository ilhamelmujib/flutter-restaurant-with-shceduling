import 'package:flutter_restaurant/data/api/api_service.dart';
import 'package:flutter_restaurant/provider/restaurant_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test("fetch retaurant", () async {
    var apiService =  ApiService();
    var restaurantProvider = RestaurantProvider(apiService: apiService);

    await restaurantProvider.fetchListRestaurant();
    expect(restaurantProvider.state, ResultState.hasData);

  });
}