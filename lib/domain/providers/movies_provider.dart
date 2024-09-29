import 'package:flutter/material.dart';
import 'package:practical/data/api_service/api_service.dart';
import 'package:practical/data/models/dashboard/movies_list.dart';

class MoviesProvider with ChangeNotifier {
  bool isLoading = false;

  startLoader() {
    isLoading = true;
    notifyListeners();
  }

  stopLoader() {
    isLoading = false;
    notifyListeners();
  }

  /// Movies List API
  List<MoviesListResults> moviesList = [];
  List<MoviesListResults> searchedMoviesList = [];

  clearMoviesList() {
    moviesList.clear();
    searchedMoviesList.clear();
    notifyListeners();
  }

  Future getMoviesList() async {
    startLoader();
    var res = await ApiService().networkService().getMoviesList();
    moviesList = searchedMoviesList = res.results!;
    stopLoader();
  }

  /// Searched Movies List
  getSearchedMoviesList(String query) {
    if (query.isEmpty) {
      searchedMoviesList = List.from(moviesList);
    } else {
      searchedMoviesList = moviesList.where((movie) {
        return movie.title!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
