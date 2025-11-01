import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_app/core/helpers/spacing.dart';
import 'package:move_app/core/theme/app_texts/app_text_styles.dart';
import 'package:move_app/core/theme/theme_manager/theme_extensions.dart';

/// A styled badge for displaying the movie's rating.
///
/// It includes a star icon and the rating text, with a gradient background.
class MovieRatingBadge extends StatelessWidget {
  /// Creates a [MovieRatingBadge].
  const MovieRatingBadge({super.key, required this.rating});

  /// The rating text to display (e.g., "8.5 / 10").
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        // A gradient background for a visually appealing look.
        gradient: LinearGradient(
          colors: context.customAppColors.greenYellowGradient,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: context.customAppColors.primary800.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // The star icon.
          Icon(
            Icons.star_rounded,
            size: 18.w,
            color: context.customAppColors.white,
          ),
          horizontalSpace(4),
          // The rating text.
          Text(
            rating,
            style: AppTextStyles.font14Bold.copyWith(
              color: context.customAppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
