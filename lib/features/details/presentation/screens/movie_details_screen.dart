import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_app/core/common/widgets/custom_loading.dart';
import 'package:move_app/core/helpers/extensions.dart';
import 'package:move_app/core/helpers/spacing.dart';
import 'package:move_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:move_app/features/details/data/models/movie_details_model.dart';
import 'package:move_app/features/details/presentation/logic/movie_details_cubit.dart';
import 'package:move_app/features/details/presentation/logic/movie_details_state.dart';
import 'package:move_app/features/details/presentation/widgets/additional_info_section.dart';
import 'package:move_app/features/details/presentation/widgets/movie_description_section.dart';
import 'package:move_app/features/details/presentation/widgets/movie_genre_badge.dart';
import 'package:move_app/features/details/presentation/widgets/movie_info_grid.dart';
import 'package:move_app/features/details/presentation/widgets/movie_poster_header.dart';
import 'package:move_app/features/details/presentation/widgets/movie_rating_badge.dart';
import 'package:move_app/features/details/presentation/widgets/movie_title_section.dart';
import 'package:move_app/features/details/presentation/widgets/production_companies_section.dart';
import 'package:move_app/features/details/presentation/widgets/watch_now_button.dart';

/// The main screen for displaying the details of a selected movie.
class MovieDetailsScreen extends StatelessWidget {
  /// The unique identifier of the movie to display.
  final int movieId;

  /// Creates a [MovieDetailsScreen].
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customAppColors.background,
      // Use a BlocBuilder to react to state changes from the MovieDetailsCubit.
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState<MovieDetailsModel>>(
        builder: (context, state) {
          // Render the UI based on the current state.
          return state.when(
            // Initial idle state.
            idle: () => const Center(child: CustomLoading(size: 200)),
            // Loading state.
            loading: () => const Center(child: CustomLoading(size: 200)),
            // Success state with movie data.
            success: (movieDetails, isFromCache) {
              return CustomScrollView(
                slivers: [
                  // The header with the movie poster and action buttons.
                  MoviePosterHeader(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500${movieDetails.posterPath}',
                    onBackPressed: () => context.pop(),
                    onFavoritePressed: () {
                      // TODO: Implement favorite functionality.
                    },
                  ),

                  // The main content area for movie details.
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(16),

                          // Section for the movie title.
                          MovieTitleSection(title: movieDetails.title ?? 'N/A'),

                          verticalSpace(12),

                          // Row for rating and language badges.
                          Row(
                            children: [
                              MovieRatingBadge(
                                rating: movieDetails.voteAverage != null
                                    ? '${movieDetails.voteAverage!.toStringAsFixed(1)} / 10 (${movieDetails.voteCount ?? 0} votes)'
                                    : 'N/A',
                              ),
                              horizontalSpace(12),
                              MovieGenreBadge(
                                genre:
                                    movieDetails.originalLanguage
                                        ?.toUpperCase() ??
                                    'N/A',
                                icon: Icons.merge_type_outlined,
                              ),
                            ],
                          ),

                          // Display movie genres if available.
                          if (movieDetails.genres != null &&
                              movieDetails.genres!.isNotEmpty) ...[
                            verticalSpace(14),
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: movieDetails.genres!.map((genre) {
                                return MovieGenreBadge(
                                  genre: genre.name ?? 'N/A',
                                );
                              }).toList(),
                            ),
                          ],

                          // Display the movie's tagline if available.
                          if (movieDetails.tagline != null &&
                              movieDetails.tagline!.isNotEmpty) ...[
                            verticalSpace(16),
                            Text(
                              '"${movieDetails.tagline}"',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontStyle: FontStyle.italic,
                                color: context.customAppColors.grey700,
                              ),
                            ),
                          ],

                          verticalSpace(24),

                          // Section for the movie description/overview.
                          MovieDescriptionSection(
                            description: movieDetails.overview ?? 'N/A',
                          ),

                          verticalSpace(24),

                          // Grid of key movie information.
                          MovieInfoGrid(movieDetails: movieDetails),

                          verticalSpace(24),

                          // Section for production companies.
                          if (movieDetails.productionCompanies != null &&
                              movieDetails.productionCompanies!.isNotEmpty) ...[
                            ProductionCompaniesSection(
                              companies: movieDetails.productionCompanies!,
                            ),
                            verticalSpace(24),
                          ],

                          // Additional info like original title, IMDb ID, and homepage.
                          if (movieDetails.originalTitle != null &&
                              movieDetails.originalTitle !=
                                  movieDetails.title) ...[
                            AdditionalInfoSection(
                              label: 'Original Title',
                              value: movieDetails.originalTitle!,
                              icon: Icons.translate_rounded,
                            ),
                            verticalSpace(12),
                          ],

                          if (movieDetails.imdbId != null &&
                              movieDetails.imdbId!.isNotEmpty) ...[
                            AdditionalInfoSection(
                              label: 'IMDB ID',
                              value: movieDetails.imdbId!,
                              icon: Icons.movie_creation_outlined,
                            ),
                            verticalSpace(12),
                          ],

                          if (movieDetails.homepage != null &&
                              movieDetails.homepage!.isNotEmpty) ...[
                            AdditionalInfoSection(
                              label: 'Official Website',
                              value: movieDetails.homepage!,
                              icon: Icons.link_rounded,
                            ),
                            verticalSpace(12),
                          ],

                          verticalSpace(20),

                          // Button to watch the movie.
                          WatchNowButton(
                            onPressed: () {
                              // TODO: Implement watch functionality.
                            },
                          ),

                          verticalSpace(32),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            // Error state.
            error: (error) => Center(
              child: Text(
                error,
                style: TextStyle(color: context.customAppColors.error500),
              ),
            ),
          );
        },
      ),
    );
  }
}
