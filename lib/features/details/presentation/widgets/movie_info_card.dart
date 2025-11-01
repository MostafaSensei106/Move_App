import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_app/core/helpers/spacing.dart';
import 'package:move_app/core/theme/app_texts/app_text_styles.dart';
import 'package:move_app/core/theme/theme_manager/theme_extensions.dart';

/// A styled card for displaying a single piece of movie information.
///
/// This widget typically shows an icon, a label, and a corresponding value.
class MovieInfoCard extends StatelessWidget {
  /// Creates a [MovieInfoCard].
  const MovieInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  /// The icon to display at the top of the card.
  final IconData icon;

  /// The label describing the information (e.g., "Duration").
  final String label;

  /// The value of the information (e.g., "2h 10m").
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.customAppColors.grey50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.customAppColors.grey200, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: context.customAppColors.grey200.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // A decorative circle behind the icon.
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: context.customAppColors.primary800.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 24.w,
              color: context.customAppColors.primary800,
            ),
          ),
          verticalSpace(8),
          // The label text.
          Text(
            label,
            style: AppTextStyles.font12Regular.copyWith(
              color: context.customAppColors.grey600,
            ),
          ),
          verticalSpace(4),
          // The value text.
          Text(
            value,
            style: AppTextStyles.font14Bold.copyWith(
              color: context.customAppColors.grey900,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
