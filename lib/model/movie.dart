class Movie {
  var id;
  var title;
  var original_title;
  var overview;
  var popularity;
  var vote_count;
  var poster_path;
  var backdrop_path;
  var original_language;
  var vote_average;
  var release_date;

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        original_title = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'],
        vote_count = json['vote_count'],
        poster_path = json['poster_path'],
        backdrop_path = json['backdrop_path'],
        original_language = json['original_language'],
        vote_average = json['vote_average'],
        release_date = json['release_date'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'original_title': original_title,
        'overview': overview,
        'popularity': popularity,
        'vote_count': vote_count,
        'poster_path': poster_path,
        'backdrop_path': backdrop_path,
        'original_language': original_language,
        'vote_average': vote_average,
        'release_date': release_date
      };
}
