import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/quote_character.dart';
import '../../business_logic/cubit/quote_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/characters.dart';
import '../../data/models/quotes.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;
  final Quote? quote;

  const CharacterDetailScreen(
      {super.key, required this.character, required this.quote});

  String extractEpisodeNumbers(List<String> episodes) {
    return episodes.map((episodeUrl) {
      final parts = episodeUrl.split('/');
      return parts.last; // الجزء الأخير من الرابط هو رقم الحلقة
    }).join(' / '); // دمج الأرقام بفاصلة ومسافة
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name,
          style: const TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget checkIfQuoteAreLoaded(QuoteCharacterState state) {
    if (state is QuoteCharacterLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: MyColors.myYellow,
        ),
      );
    } else if (state is QuoteCharacterError) {
      return Center(
        child: Text(
          state.message,
          style: const TextStyle(color: Colors.red),
        ),
      );
    } else if (state is QuoteLoaded) {
      // تأكد من أن الحالة من النوع الصحيح
      return displayRandomQuoteOrEmptySpace(state.quotes);
    } else {
      return Container(); // التعامل مع أي حالة غير متوقعة
    }
  }

  Widget displayRandomQuoteOrEmptySpace(List<Quote> quotes) {
    // var quote = (state).quote;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                  blurRadius: 7, color: MyColors.myYellow, offset: Offset(0, 0))
            ],
            fontSize: 20,
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QuoteCubit>(context).getCharactersQuotes();
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Epsodies :',
                          extractEpisodeNumbers(character.episodes)),
                      buildDivider(289),
                      characterInfo('Status :', character.status),
                      buildDivider(310),
                      characterInfo('Location Name :', character.locationName),
                      buildDivider(240),
                      character.type.isEmpty
                          ? Container()
                          : characterInfo('Type :', character.type),
                      character.type.isEmpty ? Container() : buildDivider(320),
                      characterInfo('Species :', character.species),
                      buildDivider(300),
                      characterInfo('Gender :', character.gender),
                      buildDivider(310),
                      const SizedBox(height: 20),
                      BlocBuilder<QuoteCubit, QuoteCharacterState>(
                          builder: (context, state) {
                        return checkIfQuoteAreLoaded(state);
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 500),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
