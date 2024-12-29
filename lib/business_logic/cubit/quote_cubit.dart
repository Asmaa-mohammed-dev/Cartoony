// import 'package:bloc/bloc.dart';
// import 'package:flutter_breaking/business_logic/cubit/quote_character.dart';
// import 'package:flutter_breaking/data/models/quotes.dart';
// import 'package:flutter_breaking/data/repository/quote_repository.dart';

// class QuoteCharacterError {
//   final String message;
//   QuoteCharacterError(this.message);
// }
// class QuoteCharacterLoading extends QuoteCharacterState {
//   QuoteCharacterLoading();
// }

// class QuoteCubit extends Cubit<QuoteCharacterState> {
//   final QuoteRepositry quoteRepositry;

//   List<Quote> quotes = [];

//   QuoteCubit(this.quoteRepositry) : super(QuoteCharacterInitial());

//   Future<void> getCharactersQuotes() async {
//     try {
//       emit(QuoteCharacterLoading()); // عرض حالة التحميل أثناء استرجاع البيانات
//       final Quote = await quoteRepositry.getCharactersQuotes();
//       print(
//           'Quote List: $Quote'); // الانتظار حتى يتم استرجاع البيانات
//       if (quotes.isNotEmpty) {
//         emit(QuoteLoaded(
//             quotes:
//                 quotes)); // إرسال الحالة عند تحميل البيانات بنجاح
//       } else {
//         emit(QuoteLoaded(
//             quotes: [])); // إرسال حالة فارغة إذا كانت القائمة فارغة
//       }
//     } catch (e) {
//       emit(QuoteCharacterError(
//           'Failed to load quotes: $e')); // عرض الخطأ إذا فشل استرجاع البيانات
//     }
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:flutter_breaking/business_logic/cubit/quote_character.dart';
import 'package:flutter_breaking/data/models/quotes.dart';
import 'package:flutter_breaking/data/repository/quote_repository.dart';

class QuoteCharacterError extends QuoteCharacterState {
  final String message;
  QuoteCharacterError(this.message);
}

class QuoteCharacterLoading extends QuoteCharacterState {
  QuoteCharacterLoading();
}

class QuoteCubit extends Cubit<QuoteCharacterState> {
  final QuoteRepositry quoteRepositry;

  List<Quote> quotes = [];

  QuoteCubit(this.quoteRepositry) : super(QuoteCharacterInitial());

  Future<void> getCharactersQuotes() async {
    try {
      emit(QuoteCharacterLoading()); // عرض حالة التحميل
      final quotesList = await quoteRepositry.getCharactersQuotes();
      print('Quotes List: $quotesList');

      if (quotesList.isNotEmpty) {
        quotes = quotesList; // تحديث القائمة
        emit(QuoteLoaded(quotes: quotes)); // إرسال الحالة عند النجاح
      } else {
        emit(QuoteLoaded(quotes: [])); // قائمة فارغة
      }
    } catch (e) {
      emit(QuoteCharacterError('Failed to load quotes: $e')); // عرض الخطأ
    }
  }
}
