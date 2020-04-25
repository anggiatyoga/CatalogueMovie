class FavoriteMovieModel{
  int _id;
  String _title;
  String _poster;
  String _backdropPath;
  String _overview;
  String _releaseDate;
  String _originalLanguage;
  String _genreIds;
  String _keyTrailer;

  FavoriteMovieModel(this._id, this._title, this._poster, this._backdropPath, this._overview, this._releaseDate,
      this._originalLanguage, this._genreIds, this._keyTrailer);

  FavoriteMovieModel.map(dynamic obj) {
    this._id = obj["id"];
    this._title = obj["title"];
    this._poster = obj["poster"];
    this._backdropPath = obj["backdropPath"];
    this._overview = obj["overview"];
    this._releaseDate = obj["releaseDate"];
    this._originalLanguage = obj["originalLanguage"];
    this._genreIds = obj["genreIds"];
    this._keyTrailer = obj["keyTrailer"];
  }

  String get poster => _poster;
  String get title => _title;
  int get id => _id;
  String get backdropPath => _backdropPath;
  String get overview => _overview;
  String get releaseDate => _releaseDate;
  String get originalLanguage => _originalLanguage;
  String get genreIds => _genreIds;
  String get keyTrailer => _keyTrailer;

  set poster(String value) {
    _poster = value;
  }

  set title(String value) {
    _title = value;
  }

  set id(int value) {
    _id = value;
  }

  set backdropPath(String value) {
    _backdropPath = value;
  }

  set overview(String value) {
    _overview = value;
  }

  set releaseDate(String value) {
    _releaseDate = value;
  }

  set originalLanguage(String value) {
    _originalLanguage = value;
  }

  set genreIds(String value) {
    _genreIds = value;
  }

  set keyTrailer(String value) {
    _keyTrailer = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = _id;
    map["title"] = _title;
    map["poster"] = _poster;
    map["backdropPath"] = _backdropPath;
    map["overview"] = _overview;
    map["releaseDate"] = _releaseDate;
    map["originalLanguage"] = _originalLanguage;
    map["genreIds"] = _genreIds;
    map["keyTrailer"] = _keyTrailer;
    return map;
  }




}