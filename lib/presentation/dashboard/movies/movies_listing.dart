import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practical/domain/providers/movies_provider.dart';
import 'package:practical/shared/constants/colors.dart';
import 'package:practical/shared/constants/miscellaneous.dart';
import 'package:practical/shared/constants/strings.dart';
import 'package:practical/shared/utils/responsive_manager.dart';
import 'package:practical/shared/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'widgets/movie_info_card.dart';

class MoviesListingScreen extends StatefulWidget {
  const MoviesListingScreen({super.key});

  @override
  State<MoviesListingScreen> createState() => _MoviesListingScreenState();
}

class _MoviesListingScreenState extends State<MoviesListingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await getMoviesList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: movies,
        onSearchChanged: _onSearch,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator.adaptive(
      onRefresh: getMoviesList,
      color: kPrimaryColor,
      child: Consumer<MoviesProvider>(
        builder:
            (BuildContext context, MoviesProvider provider, Widget? child) {
          bool isLoading = provider.isLoading;
          return Skeletonizer(
            enabled: isLoading,
            child: ListView.builder(
              padding: EdgeInsets.only(top: ResponsiveManager.height(1)),
              shrinkWrap: true,
              itemCount: isLoading ? 10 : provider.searchedMoviesList.length,
              dragStartBehavior: DragStartBehavior.down,
              itemBuilder: (BuildContext context, int index) {
                String imageUrl = isLoading
                    ? ""
                    : 'https://image.tmdb.org/t/p/w500${provider.searchedMoviesList[index].posterPath}';
                String name = isLoading
                    ? 'Movie Name'
                    : provider.searchedMoviesList[index].title ?? "";
                String overview = isLoading
                    ? 'Movie Overview'
                    : provider.searchedMoviesList[index].overview ?? "";
                String releaseDate = isLoading
                    ? "Movie Release Date"
                    : provider.searchedMoviesList[index].releaseDate ?? "";
                String rating = isLoading
                    ? "Movie Rating"
                    : provider.searchedMoviesList[index].voteAverage.toString();
                return FadeIn(
                  curve: Curves.easeIn,
                  duration: isLoading ? Duration.zero : kMovieCardDuration,
                  child: MovieInfoCard(
                    imageUrl: imageUrl,
                    name: name,
                    overview: overview,
                    releaseDate: releaseDate,
                    rating: rating,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _onSearch(String value) {
    var provider = Provider.of<MoviesProvider>(context, listen: false);
    provider.getSearchedMoviesList(value);
  }

  /// API Calls--------------------------
  Future getMoviesList() async {
    var provider = Provider.of<MoviesProvider>(context, listen: false);
    provider.clearMoviesList();
    await provider.getMoviesList();
  }
}
