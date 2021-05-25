class TextState {
  String title;
  String description;
  String mainImage;
  var options = [];
  bool isEnd;

  TextState(this.title, this.description, this.options,
      {this.mainImage = "", this.isEnd = false});
}
