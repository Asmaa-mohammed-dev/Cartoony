import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../data/models/characters.dart';
import '../../data/repository/character_repositry.dart';

part 'character_state.dart';

// class CharacterCubit extends Cubit<CharacterState> {
//   final CharactersRepositry charactersRepositry;
//   List<Character> characters = [];
//   CharacterCubit(this.charactersRepositry) : super(CharacterInitial());

//   List<Character> getAllCharacters() {
//     charactersRepositry.getAllCharacters().then((characters) {
//       emit(CharacterLoaded(characters: characters));
//       this.characters = characters;
//     });
//     return characters;
//   }
// }
class CharacterLoading extends CharacterState {
  CharacterLoading();
}

class CharacterError extends CharacterState {
  final String message;
  CharacterError(this.message);
}

class CharacterCubit extends Cubit<CharacterState> {
  final CharactersRepositry charactersRepositry;

  List<Character> characters = [];

  CharacterCubit(this.charactersRepositry) : super(CharacterInitial());

  Future<void> getAllCharacters() async {
    try {
      emit(CharacterLoading()); // عرض حالة التحميل أثناء استرجاع البيانات
      final charactersList = await charactersRepositry.getAllCharacters();
      print(
          'Characters List: $charactersList'); // الانتظار حتى يتم استرجاع البيانات
      if (charactersList.isNotEmpty) {
        emit(CharacterLoaded(
            characters:
                charactersList)); // إرسال الحالة عند تحميل البيانات بنجاح
      } else {
        emit(CharacterLoaded(
            characters: [])); // إرسال حالة فارغة إذا كانت القائمة فارغة
      }
    } catch (e) {
      emit(CharacterError(
          'Failed to load characters: $e')); // عرض الخطأ إذا فشل استرجاع البيانات
    }
  }
}
