import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_app/core/helpers/spacing.dart';
import 'package:move_app/core/theme/app_texts/app_text_styles.dart';
import 'package:move_app/core/theme/theme_manager/theme_extensions.dart';

/// A styled badge widget for displaying a movie genre or similar information.
class MovieGenreBadge extends StatelessWidget {
  /// Creates a [MovieGenreBadge].
  const MovieGenreBadge({super.key, required this.genre, this.icon});

  /// The text to display in the badge (e.g., the genre name).
  final String genre;

  /// An optional icon to display in the badge.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: context.customAppColors.primary800.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: context.customAppColors.primary800.withOpacity(0.3),
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          // Display the icon, or a default one if not provided.
          Icon(
            icon ?? Icons.movie_filter_outlined,
            size: 16.w,
            color: context.customAppColors.primary800,
          ),
          horizontalSpace(6),
          // Display the genre text.
          Text(
            genre,
            style: AppTextStyles.font13Bold.copyWith(
              color: context.customAppColors.primary800,
            ),
          ),
        ],
      ),
    );
  }
}
