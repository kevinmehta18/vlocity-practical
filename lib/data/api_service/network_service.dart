
import 'package:dio/dio.dart';
import 'package:practical/data/models/dashboard/movies_list.dart';
import 'package:practical/shared/constants/strings.dart';
import 'package:practical/shared/constants/uri.dart';

import 'package:retrofit/retrofit.dart';
part 'network_service.g.dart';

@RestApi(baseUrl: "")
abstract class NetworkService {
  factory NetworkService(Dio dio,) = _NetworkService;

  @GET(moviesListingUrl)
  Future<MoviesList> getMoviesList();

  
}
