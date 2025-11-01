import 'package:flutter/material.dart';
import 'package:move_app/core/theme/app_texts/app_text_styles.dart';
import 'package:move_app/core/theme/theme_manager/theme_extensions.dart';

/// A widget that displays the movie title with a prominent, bold text style.
class MovieTitleSection extends StatelessWidget {
  /// Creates a [MovieTitleSection].
  const MovieTitleSection({super.key, required this.title});

  /// The title of the movie to display.
  final String title;

  @override
  Widget build(BuildContext context) {
    // A Text widget styled to be large and bold for the title.
    return Text(
      title,
      style: AppTextStyles.font32Bold.copyWith(
        color: context.customAppColors.grey900,
        height: 1.2, // Adjust line height for better visual spacing.
      ),
    );
  }
}
