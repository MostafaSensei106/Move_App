import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_app/core/helpers/spacing.dart';

import '../../../../core/theme/app_texts/app_text_styles.dart';
import '../../../../core/theme/theme_manager/theme_cubit.dart';
import '../../../../core/theme/theme_manager/theme_extensions.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  // Handle theme selection and close the bottom sheet
  void _selectTheme(BuildContext context, ThemeMode themeMode) {
    if (context.read<ThemeCubit>().state != themeMode) {
      context.read<ThemeCubit>().updateTheme(themeMode);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<ThemeCubit>().state;

    return Container(
      decoration: BoxDecoration(
        color: context.customAppColors.grey50,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: context.customAppColors.grey300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: context.customAppColors.primary500.withValues(
                      alpha: 0.1,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.palette_rounded,
                    size: 20.r,
                    color: context.customAppColors.primary500,
                  ),
                ),
                horizontalSpace(12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Theme',
                      style: AppTextStyles.font18Bold.copyWith(
                        color: context.customAppColors.grey900,
                      ),
                    ),
                    verticalSpace(2),
                    Text(
                      'Select your preferred app appearance',
                      style: AppTextStyles.font18Regular.copyWith(
                        fontSize: 14.sp,
                        color: context.customAppColors.grey600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Divider(
            height: 1.h,
            thickness: 1,
            indent: 16.w,
            endIndent: 16.w,
            color: context.customAppColors.grey200,
          ),

          verticalSpace(16),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                _ThemeOption(
                  title: 'Light Theme',
                  subtitle: 'Clean and bright interface',
                  icon: Icons.light_mode_rounded,
                  themeMode: ThemeMode.light,
                  isSelected: currentTheme == ThemeMode.light,
                  onTap: () => _selectTheme(context, ThemeMode.light),
                ),
                verticalSpace(12),
                _ThemeOption(
                  title: 'Dark Theme',
                  subtitle: 'Easy on the eyes in low light',
                  icon: Icons.dark_mode_rounded,
                  themeMode: ThemeMode.dark,
                  isSelected: currentTheme == ThemeMode.dark,
                  onTap: () => _selectTheme(context, ThemeMode.dark),
                ),
                verticalSpace(12),
                _ThemeOption(
                  title: 'System Theme',
                  subtitle: 'Matches your device settings',
                  icon: Icons.brightness_auto_rounded,
                  themeMode: ThemeMode.system,
                  isSelected: currentTheme == ThemeMode.system,
                  onTap: () => _selectTheme(context, ThemeMode.system),
                ),
              ],
            ),
          ),

          verticalSpace(24),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final ThemeMode themeMode;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.themeMode,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? context.customAppColors.primary500
                : context.customAppColors.grey300,
            width: 2,
          ),
          color: isSelected
              ? context.customAppColors.primary500.withValues(alpha: 0.08)
              : context.customAppColors.grey50,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.customAppColors.primary500
                      : context.customAppColors.grey200,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: context.customAppColors.primary500
                                .withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  icon,
                  color: isSelected
                      ? context.customAppColors.grey0
                      : context.customAppColors.grey600,
                  size: 24.r,
                ),
              ),

              horizontalSpace(16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font18Bold.copyWith(
                        fontSize: 16.sp,
                        color: context.customAppColors.grey900,
                      ),
                    ),

                    verticalSpace(4),

                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font18Regular.copyWith(
                        fontSize: 14.sp,
                        color: context.customAppColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),

              horizontalSpace(12),

              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? context.customAppColors.primary500
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? context.customAppColors.primary500
                        : context.customAppColors.grey400,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        size: 16.r,
                        color: context.customAppColors.grey0,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
