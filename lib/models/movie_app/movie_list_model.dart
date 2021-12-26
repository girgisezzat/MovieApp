class MovieListModel {
  String? listName;
  String? listId;

  MovieListModel({
    this.listName,
    this.listId,
  });


  MovieListModel.fromJson(Map<String, dynamic> json)
  {
    listName = json['listName'];
    listId = json['listId'];
  }


  Map<String, dynamic> toMap()
  {
    return {
      'listName':listName,
      'listId':listId,
    };
  }

}