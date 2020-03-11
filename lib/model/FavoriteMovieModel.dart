class FavoriteMovieModel{
  int _id;
  String _title;
  String _poster;

  FavoriteMovieModel(this._id, this._title, this._poster);

  FavoriteMovieModel.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._poster = map['poster'];
  }

  String get poster => _poster;
  set poster(String value) {
    _poster = value;
  }
  String get title => _title;

  set title(String value) {
    _title = value;
  }
  int get id => _id;
  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['title'] = this._title;
    map['poster'] = this._poster;
    return map;
  }


}