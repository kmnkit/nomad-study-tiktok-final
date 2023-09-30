import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:study_final/constants/emojis.dart';
import 'package:study_final/features/moods/models/mood.dart';

class MoodCard extends StatelessWidget {
  const MoodCard({
    super.key,
    required this.mood,
    required this.onLoveTap,
    required this.isLoved,
  });

  final MoodModel mood;
  final Function onLoveTap;
  final bool isLoved;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("MOOD: ${emojis[mood.emojiIndex]}"),
                Text(
                  mood.text,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            GestureDetector(
              onTap: () => onLoveTap(),
              child: FaIcon(
                FontAwesomeIcons.solidHeart,
                color: isLoved ? Colors.red : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
