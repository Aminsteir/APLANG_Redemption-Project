class TextState {
  String title;
  String description;
  String image;
  var options = [];
  bool isEnd;

  TextState(this.title, this.description, this.options,
      {this.image = "", this.isEnd = false});
}
