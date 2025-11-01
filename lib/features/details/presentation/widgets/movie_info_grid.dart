import 'package:flutter/material.dart';
import 'package:move_app/core/helpers/spacing.dart';
import 'package:move_app/features/details/data/models/movie_details_model.dart';
import 'package:move_app/features/details/presentation/widgets/movie_info_card.dart';

/// A widget that displays a grid of key movie information using [MovieInfoCard]s.
class MovieInfoGrid extends StatelessWidget {
  /// The movie details data to display.
  final MovieDetailsModel movieDetails;

  /// Creates a [MovieInfoGrid].
  const MovieInfoGrid({super.key, required this.movieDetails});

  /// Formats a duration in minutes into a more readable string (e.g., "1h 30m").
  String _formatRuntime(int? minutes) {
    if (minutes == null) return 'N/A';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours > 0) {
      return '${hours}h ${mins}m';
    }
    return '${mins}m';
  }

  /// Formats a large integer representing revenue into a compact string (e.g., "$1.2B").
  String _formatRevenue(int? revenue) {
    if (revenue == null || revenue == 0) return 'N/A';
    if (revenue >= 1000000000) {
      return '\$${(revenue / 1000000000).toStringAsFixed(1)}B';
    } else if (revenue >= 1000000) {
      return '\$${(revenue / 1000000).toStringAsFixed(1)}M';
    } else if (revenue >= 1000) {
      return '\$${(revenue / 1000).toStringAsFixed(1)}K';
    }
    return '\$$revenue';
  }

  /// Formats a large integer representing a budget into a compact string (e.g., "$150M").
  String _formatBudget(int? budget) {
    if (budget == null || budget == 0) return 'N/A';
    if (budget >= 1000000000) {
      return '\$${(budget / 1000000000).toStringAsFixed(1)}B';
    } else if (budget >= 1000000) {
      return '\$${(budget / 1000000).toStringAsFixed(1)}M';
    } else if (budget >= 1000) {
      return '\$${(budget / 1000).toStringAsFixed(1)}K';
    }
    return '\$$budget';
  }

  @override
  Widget build(BuildContext context) {
    // A column containing rows of MovieInfoCards.
    return Column(
      children: [
        // First row: Duration and Release Date.
        Row(
          children: [
            Expanded(
              child: MovieInfoCard(
                icon: Icons.access_time_rounded,
                label: 'Duration',
                value: _formatRuntime(movieDetails.runtime),
              ),
            ),
            horizontalSpace(12),
            Expanded(
              child: MovieInfoCard(
                icon: Icons.calendar_today_rounded,
                label: 'Release',
                value: movieDetails.releaseDate ?? 'N/A',
              ),
            ),
          ],
        ),
        verticalSpace(12),
        // Second row: Language and Status.
        Row(
          children: [
            Expanded(
              child: MovieInfoCard(
                icon: Icons.language_rounded,
                label: 'Language',
                value: movieDetails.spokenLanguages?.isNotEmpty == true
                    ? movieDetails.spokenLanguages!.first.englishName ?? 'N/A'
                    : 'N/A',
              ),
            ),
            horizontalSpace(12),
            Expanded(
              child: MovieInfoCard(
                icon: Icons.info_outline_rounded,
                label: 'Status',
                value: movieDetails.status ?? 'N/A',
              ),
            ),
          ],
        ),
        verticalSpace(12),
        // Third row: Budget and Revenue.
        Row(
          children: [
            Expanded(
              child: MovieInfoCard(
                icon: Icons.attach_money_rounded,
                label: 'Budget',
                value: _formatBudget(movieDetails.budget),
              ),
            ),
            horizontalSpace(12),
            Expanded(
              child: MovieInfoCard(
                icon: Icons.trending_up_rounded,
                label: 'Revenue',
                value: _formatRevenue(movieDetails.revenue),
              ),
            ),
          ],
        ),
        verticalSpace(12),
        // Fourth row: Country and Popularity.
        Row(
          children: [
            Expanded(
              child: MovieInfoCard(
                icon: Icons.public_rounded,
                label: 'Country',
                value: movieDetails.productionCountries?.isNotEmpty == true
                    ? movieDetails.productionCountries!.first.name ?? 'N/A'
                    : 'N/A',
              ),
            ),
            horizontalSpace(12),
            Expanded(
              child: MovieInfoCard(
                icon: Icons.star_border_rounded,
                label: 'Popularity',
                value: movieDetails.popularity != null
                    ? movieDetails.popularity!.toStringAsFixed(1)
                    : 'N/A',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
