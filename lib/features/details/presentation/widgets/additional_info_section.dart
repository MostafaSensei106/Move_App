import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_app/core/helpers/spacing.dart';
import 'package:move_app/core/theme/app_texts/app_text_styles.dart';
import 'package:move_app/core/theme/theme_manager/theme_extensions.dart';

/// A widget to display a piece of labeled information, often with an icon.
class AdditionalInfoSection extends StatelessWidget {
  /// Creates an [AdditionalInfoSection].
  const AdditionalInfoSection({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  /// The label for the information (e.g., "Original Title").
  final String label;

  /// The value of the information (e.g., the actual title).
  final String value;

  /// An optional icon to display next to the information.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: context.customAppColors.grey50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.customAppColors.grey200, width: 1.w),
      ),
      child: Row(
        children: [
          // Display the icon if it's provided.
          if (icon != null) ...[
            Icon(icon, size: 20.w, color: context.customAppColors.primary800),
            horizontalSpace(12),
          ],
          // The main content with the label and value.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  style: AppTextStyles.font14Regular.copyWith(
                    color: context.customAppColors.grey900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
