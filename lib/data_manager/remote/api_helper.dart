library constants;

const String BASE_URL = "api.themoviedb.org";
const String IMAGE_URL = "https://image.tmdb.org/t/p/w500/";
const String API_KEY = "6cb025fee4cbfb787415c63d5fa87583";

const String TOP_RATED = "3/movie/top_rated";
const String SEARCH = "3/search/movie";

Uri getTopRated(var page) {
  return new Uri.https(
      BASE_URL, TOP_RATED, {"page": page.toString(), "api_key": API_KEY});
}

Uri searchMovies(var query) {
  return new Uri.https(BASE_URL, SEARCH, {"query": query, "api_key": API_KEY});
}
