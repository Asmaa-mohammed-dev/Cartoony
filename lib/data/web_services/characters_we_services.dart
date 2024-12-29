import 'package:dio/dio.dart';
import '../../constants/strings.dart';

class CharactersWebServices {
  late Dio dio;
  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60 * 1000),
      receiveTimeout: const Duration(seconds: 60 * 1000), // 60 seconds
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      // تأكد من أن الـ baseUrl في ملف strings.dart يحتوي على الـ URL الصحيح
      Response response = await dio.get(
          'character'); // استخدم 'character' إذا كان URL الكامل هو https://rickandmortyapi.com/api/character
      print('Response: ${response.data}');

      if (response.data != null && response.data['results'] != null) {
        // إعادة البيانات من results فقط
        return response
            .data['results']; // إرجاع البيانات التي تحتوي على الشخصيات
      } else {
        return []; // إرجاع قائمة فارغة إذا لم تكن هناك نتائج
      }
    } catch (e) {
      print('Error: $e');
      return []; // في حالة حدوث خطأ، إرجاع قائمة فارغة
    }
  }
}
// Future<List<dynamic>> getCharactersQuotes() async {
//     try {
//       Response response = await dio.get('quote');
//       print(response.data.toString());
//       return response.data;
//     } catch (e) {
//       print(e.toString());
//       return [];
//     }

//   }
