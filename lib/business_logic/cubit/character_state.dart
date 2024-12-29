part of 'character_cubit.dart';

@immutable
sealed class CharacterState {}

final class CharacterInitial extends CharacterState {}
// class CharactersErrorCase extends CharacterState{
//   final String message;

//   CharactersErrorCase({required this.message});
// }
class CharacterLoaded extends CharacterState {
  final List<Character> characters;

  CharacterLoaded({required this.characters});
}
