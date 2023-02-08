import 'package:flutter_restaurant/data/api/api_service.dart';
import 'package:flutter_restaurant/data/model/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test("parsing json", () async {
    // arrange
    var apiService = ApiService();

    // act
    var list = await apiService.getList();

    // assert
    var result = list.error == false;
    expect(result, true);

  });
}