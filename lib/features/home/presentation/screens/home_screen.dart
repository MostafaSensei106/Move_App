import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_app/core/common/widgets/theme_bottom_sheet.dart';
import 'package:move_app/features/home/presentation/widgets/all_movies_list.dart';

import '../../../../core/theme/app_texts/app_text_styles.dart';
import '../../../../core/theme/theme_manager/theme_extensions.dart';

/// The main screen of the application, displaying a list of popular movies.
class HomeScreen extends StatelessWidget {
  /// Creates a [HomeScreen].
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customAppColors.background,
      appBar: AppBar(
        backgroundColor: context.customAppColors.background,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        // The title of the app bar.
        title: Text(
          '🎬 Movies',
          style: AppTextStyles.font18Bold.copyWith(
            color: context.customAppColors.grey900,
          ),
        ),
        centerTitle: true,
        // An action button to open the theme selection bottom sheet.
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const ThemeBottomSheet(),
              );
            },
            icon: Icon(
              Icons.spa_rounded, // An icon suggesting theme/appearance.
              size: 24.w,
              color: context.customAppColors.primary800,
            ),
          ),
        ],
      ),
      // The body of the screen, which contains the list of movies.
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: AllMoviesList(),
      ),
    );
  }
}
