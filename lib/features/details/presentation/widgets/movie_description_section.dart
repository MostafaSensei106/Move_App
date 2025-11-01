import 'package:flutter/material.dart';
import 'package:move_app/core/helpers/spacing.dart';
import 'package:move_app/core/theme/app_texts/app_text_styles.dart';
import 'package:move_app/core/theme/theme_manager/theme_extensions.dart';

/// A widget that displays the movie's description or overview with a title.
class MovieDescriptionSection extends StatelessWidget {
  /// Creates a [MovieDescriptionSection].
  const MovieDescriptionSection({super.key, required this.description});

  /// The description text to display.
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The title of the section.
        Text(
          'About Movie',
          style: AppTextStyles.font20Bold.copyWith(
            color: context.customAppColors.grey900,
          ),
        ),
        verticalSpace(12),
        // The main description text.
        Text(
          description,
          style: AppTextStyles.font14Regular.copyWith(
            color: context.customAppColors.grey700,
            height: 1.6, // Line height for better readability.
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
