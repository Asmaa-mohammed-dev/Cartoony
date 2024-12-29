import '../models/quotes.dart';
import '../web_services/Quote_we_services.dart';
import '../web_services/characters_we_services.dart';

class QuoteRepositry {
  final CharactersWebServices charactersWebServices;

  QuoteRepositry(
      {required this.charactersWebServices, required quoteWebServices});
  final QuoteWebServices quoteWebServices = QuoteWebServices();

  Future<List<Quote>> getCharactersQuotes() async {
    final quotes = await quoteWebServices.getCharactersQuotes();
    print('Quotes from API: $quotes');
    return quotes.map((quote) => Quote.fromJson(quote)).toList();
  }
}
