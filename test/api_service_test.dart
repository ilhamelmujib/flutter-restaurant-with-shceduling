import 'package:flutter_restaurant/data/api/api_service.dart';
import 'package:flutter_restaurant/data/model/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'api_service_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('getList', () {
    test('Test Fetched Data', () async {
      final client = MockClient();

      when(client.get(Uri.parse("${ApiService.baseUrl}list"))).thenAnswer(
          (_) async => http.Response(
              '{"error":false, "message": "success", "count": 20}', 200));

      expect(await ApiService().getList(client), isA<ListRestaurantResult>());
    });

    test('Test Error', () async {
      final client = MockClient();

      when(client
          .get(Uri.parse("${ApiService.baseUrl}list")))
          .thenAnswer((_) async => http.Response('{"statusCode": 404, "error": "Not Found", "message": "Not Found"}', 404));

      expect(ApiService().getList(client), throwsException);
    });
  });
}
