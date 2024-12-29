import 'package:dio/dio.dart';
import '../../constants/strings.dart';

class QuoteWebServices {
  late Dio dio;
  QuoteWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrlQuote,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60 * 1000),
      receiveTimeout: const Duration(seconds: 60 * 1000), // 60 seconds
    );
    dio = Dio(options);
  }
  Future<List<dynamic>> getCharactersQuotes() async {
    try {
      Response response = await dio.get('bulk');
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
