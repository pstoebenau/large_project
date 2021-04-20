class Snippet {
  final String id;
  final String userID;
  final String imageURL;
  final int score;

  Snippet(this.id, this.userID, this.imageURL, this.score);
  Snippet.positional({ this.id, this.userID, this.imageURL, this.score });

  factory Snippet.empty() {
    return Snippet('', '', '', -1);
  }

  factory Snippet.fromJson(Map json) {
    return Snippet.positional(
      id: json['id'] ?? '',
      userID: json['userID'] ?? '',
      imageURL: json['imageURL'] ?? '',
      score: json['score'] ?? -1,
    );
  }

  Map<String, dynamic> toJson(Snippet snippet) {
    return {
      'id': snippet.id,
      'userID': snippet.userID,
      'imageURL': snippet.imageURL,
      'score': snippet.score,
    };
  }
}