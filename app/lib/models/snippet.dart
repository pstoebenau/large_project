class Snippet {
  final int id;
  final int userID;
  final String imageURL;
  final int score;

  Snippet(this.id, this.userID, this.imageURL, this.score);

  Snippet.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userID = json['userID'],
        imageURL = json['imageURL'],
        score = json['score'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'userID': userID,
        'imageUrl': imageURL,
        'score': score,
      };
}