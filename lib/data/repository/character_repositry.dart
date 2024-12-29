import '../models/characters.dart';
import '../web_services/characters_we_services.dart';

class CharactersRepositry {
  final CharactersWebServices charactersWebServices;

  CharactersRepositry({required this.charactersWebServices});
  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    print('Characters from API: $characters');
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
