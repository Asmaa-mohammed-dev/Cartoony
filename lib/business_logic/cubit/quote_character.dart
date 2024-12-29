import 'package:flutter/material.dart';
import '../../data/models/quotes.dart';

@immutable
class QuoteCharacterState {}

final class QuoteCharacterInitial extends QuoteCharacterState {}

class QuoteLoaded extends QuoteCharacterState {
  final List<Quote> quotes;

  QuoteLoaded({required this.quotes});
}
