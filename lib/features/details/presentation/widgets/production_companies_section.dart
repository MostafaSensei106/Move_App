import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_app/core/helpers/spacing.dart';
import 'package:move_app/core/theme/app_texts/app_text_styles.dart';
import 'package:move_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:move_app/features/details/data/models/movie_details_model.dart';

/// A widget that displays a list of production companies.
class ProductionCompaniesSection extends StatelessWidget {
  /// Creates a [ProductionCompaniesSection].
  const ProductionCompaniesSection({super.key, required this.companies});

  /// The list of [ProductionCompany] to display.
  final List<ProductionCompany> companies;

  @override
  Widget build(BuildContext context) {
    // If there are no companies, return an empty widget.
    if (companies.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The title of the section.
        Text(
          'Production Companies',
          style: AppTextStyles.font16Bold.copyWith(
            color: context.customAppColors.grey900,
          ),
        ),
        verticalSpace(12),
        // A Wrap widget to display the company badges, which will wrap to the next line if needed.
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: companies.map((company) {
            // A styled container for each company.
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: context.customAppColors.grey50,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: context.customAppColors.grey200,
                  width: 1.w,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // An icon representing a business.
                  Icon(
                    Icons.business_rounded,
                    size: 16.w,
                    color: context.customAppColors.primary800,
                  ),
                  horizontalSpace(6),
                  // The name of the company.
                  Text(
                    company.name ?? 'N/A',
                    style: AppTextStyles.font13Regular.copyWith(
                      color: context.customAppColors.grey900,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
