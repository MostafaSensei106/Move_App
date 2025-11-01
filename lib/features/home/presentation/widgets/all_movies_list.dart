import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_app/core/common/widgets/custom_loading.dart';
import 'package:move_app/core/helpers/extensions.dart';
import 'package:move_app/core/routing/routes.dart';
import 'package:move_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:move_app/features/home/data/models/all_movies_model.dart';
import 'package:move_app/features/home/presentation/logic/all_movies_cubit.dart';
import 'package:move_app/features/home/presentation/logic/all_movies_state.dart';
import 'package:move_app/features/home/presentation/widgets/all_movies_card.dart';

/// A widget that displays a list of all movies in a grid, with support for
/// infinite scrolling and pull-to-refresh.
class AllMoviesList extends StatefulWidget {
  /// Creates an [AllMoviesList].
  const AllMoviesList({super.key});

  @override
  State<AllMoviesList> createState() => _AllMoviesListState();
}

class _AllMoviesListState extends State<AllMoviesList> {
  // Scroll controller to detect when the user reaches the bottom of the list.
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Add a listener to the scroll controller to trigger loading more movies.
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// Called when the user scrolls the list.
  void _onScroll() {
    // If the user is near the bottom of the list, load more movies.
    if (_isBottom) {
      context.read<AllMoviesCubit>().loadMoreMovies();
    }
  }

  /// Checks if the user has scrolled to the bottom of the list.
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Trigger loading when the user is at 90% of the max scroll extent.
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    // Use a BlocBuilder to listen to state changes from the AllMoviesCubit.
    return BlocBuilder<AllMoviesCubit, AllMoviesState<AllMoviesModel>>(
      builder: (context, state) {
        // Render the UI based on the current state.
        return state.when(
          idle: () => const Center(child: CustomLoading(size: 200)),
          loading: () => const Center(child: CustomLoading(size: 200)),
          success: (allMovies, isFromCache) {
            return _buildMovieGrid(allMovies, showLoadingMore: false);
          },
          loadingMore: (allMovies) {
            return _buildMovieGrid(allMovies, showLoadingMore: true);
          },
          error: (error) => Center(
            child: Text(
              error,
              style: TextStyle(color: context.customAppColors.error500),
            ),
          ),
        );
      },
    );
  }

  /// Builds the grid of movie cards.
  ///
  /// - [allMovies]: The data model containing the list of movies.
  /// - [showLoadingMore]: A flag to show a loading indicator at the bottom.
  Widget _buildMovieGrid(
    AllMoviesModel allMovies, {
    required bool showLoadingMore,
  }) {
    // Add 1 to the item count if we need to show the loading indicator.
    final itemCount =
        (allMovies.results?.length ?? 0) + (showLoadingMore ? 1 : 0);

    // A pull-to-refresh indicator to allow users to refresh the movie list.
    return RefreshIndicator(
      onRefresh: () async {
        context.read<AllMoviesCubit>().emitGetAllMovies();
      },
      color: context.customAppColors.primary500,
      backgroundColor: context.customAppColors.background,
      child: GridView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 16.r, bottom: 24.r),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Display two cards per row.
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75, // Adjust the aspect ratio of the cards.
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          // If we are at the end of the list and loading more, show a loading indicator.
          if (showLoadingMore && index == allMovies.results!.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CustomLoading(size: 50),
              ),
            );
          }

          // Build a movie card for each movie in the list.
          return AllMoviesCard(
            movie: allMovies.results![index],
            onTap: () {
              // Navigate to the movie details screen on tap.
              context.pushNamed(
                Routes.movieDetailsScreen,
                arguments: allMovies.results![index].id,
              );
            },
          );
        },
      ),
    );
  }
}
