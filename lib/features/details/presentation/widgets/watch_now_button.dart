import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_app/core/helpers/spacing.dart';
import 'package:move_app/core/theme/app_texts/app_text_styles.dart';
import 'package:move_app/core/theme/theme_manager/theme_extensions.dart';

/// A prominent call-to-action button for watching a movie.
class WatchNowButton extends StatelessWidget {
  /// Creates a [WatchNowButton].
  const WatchNowButton({super.key, required this.onPressed});

  /// The callback function that is executed when the button is pressed.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Make the button take the full width.
      height: 56.h, // Set a fixed height for the button.
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.customAppColors.primary800,
          foregroundColor: context.customAppColors.white,
          elevation: 4,
          shadowColor: context.customAppColors.primary800.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // The play icon.
            Icon(Icons.play_circle_filled_rounded, size: 28.w),
            horizontalSpace(12),
            // The button text.
            Text(
              'Watch Now',
              style: AppTextStyles.font18Bold.copyWith(
                color: context.customAppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
