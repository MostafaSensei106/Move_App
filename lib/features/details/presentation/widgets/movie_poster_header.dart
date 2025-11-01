import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_app/core/common/widgets/custom_loading.dart';
import 'package:move_app/core/theme/theme_manager/theme_extensions.dart';

/// A sliver app bar that displays a movie poster as its flexible background.
///
/// It includes a back button and a favorite button as leading and actions widgets.
class MoviePosterHeader extends StatelessWidget {
  /// Creates a [MoviePosterHeader].
  const MoviePosterHeader({
    super.key,
    required this.imageUrl,
    required this.onBackPressed,
    required this.onFavoritePressed,
  });

  /// The URL of the movie poster image to display.
  final String imageUrl;

  /// A callback function for when the back button is pressed.
  final VoidCallback onBackPressed;

  /// A callback function for when the favorite button is pressed.
  final VoidCallback onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 400.h, // The height of the app bar when fully expanded.
      pinned: true, // The app bar will remain visible at the top.
      backgroundColor: context.customAppColors.background,
      surfaceTintColor: Colors.transparent, // Remove the default tint color.
      // The back button.
      leading: Container(
        margin: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: context.customAppColors.background.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: context.customAppColors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: IconButton(
          onPressed: onBackPressed,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: context.customAppColors.grey900,
            size: 20.w,
          ),
        ),
      ),
      // The favorite button.
      actions: [
        Container(
          margin: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: context.customAppColors.background.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: context.customAppColors.black.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: IconButton(
            onPressed: onFavoritePressed,
            icon: Icon(
              Icons.favorite_border_rounded,
              color: context.customAppColors.error700,
              size: 24.w,
            ),
          ),
        ),
      ],
      // The flexible space that contains the poster image.
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Use CachedNetworkImage for efficient image loading and caching.
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Container(
                  color: context.customAppColors.primary300.withOpacity(0.4),
                  child: const Center(child: CustomLoading(size: 150)),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  color: context.customAppColors.primary300.withOpacity(0.4),
                  child: Center(
                    child: Image.asset(
                      'assets/images/map.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            // A gradient overlay to make the content at the bottom more readable.
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    context.customAppColors.black.withOpacity(0.3),
                    context.customAppColors.background.withOpacity(0.95),
                  ],
                  stops: const [0.4, 0.75, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
