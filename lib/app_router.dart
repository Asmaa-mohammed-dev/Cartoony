import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/cubit/character_cubit.dart';
import 'business_logic/cubit/quote_cubit.dart';
import 'constants/strings.dart';
import 'data/models/characters.dart';
import 'data/models/quotes.dart';
import 'data/repository/character_repositry.dart';
import 'data/repository/quote_repository.dart';
import 'data/web_services/Quote_we_services.dart';
import 'data/web_services/characters_we_services.dart';
import 'presentation/screens/character_screen.dart';
import 'presentation/screens/characters_details_screen.dart';

class AppRouter {
  late CharactersRepositry charactersRepositry;
  late CharacterCubit characterCubit;
  late QuoteRepositry quoteRepositry;
  late QuoteCubit quoteCubit;

  AppRouter() {
    charactersRepositry =
        CharactersRepositry(charactersWebServices: CharactersWebServices());
    characterCubit = CharacterCubit(charactersRepositry);
    quoteRepositry = QuoteRepositry(
        quoteWebServices: QuoteWebServices(),
        charactersWebServices: CharactersWebServices());
    quoteCubit = QuoteCubit(quoteRepositry);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext contxt) =>
                CharacterCubit(charactersRepositry),
            child: const CharacterScreen(),
          ),
        );
      // case characterDetailsScreen:
      //   // final character = settings.arguments as Character;
      //   // final quote = settings.arguments as Quote;
      //   final args = settings.arguments as CharacterAndQuote;

      //   return MaterialPageRoute(
      //     builder: (_) => CharacterDetailScreen(
      //         character: args.character, quote: args.quote),
      //   );
      case characterDetailsScreen:
        if (settings.arguments is CharacterAndQuote) {
          final args = settings.arguments as CharacterAndQuote;
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (BuildContext context) => QuoteCubit(quoteRepositry),
              child: CharacterDetailScreen(
                character: args.character,
                quote: args.quote,
              ),
            ),
          );
        } else if (settings.arguments is Character) {
          final character = settings.arguments as Character;
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (BuildContext context) => QuoteCubit(quoteRepositry),
              child: CharacterDetailScreen(
                character: character,
                quote: null, // اقتباس فارغ
              ),
            ),
          );
        } else {
          throw Exception('Invalid arguments for $characterDetailsScreen');
        }
    }
  }
}

class CharacterAndQuote {
  final Character character;
  final Quote? quote;

  CharacterAndQuote({required this.character, required this.quote});
}
