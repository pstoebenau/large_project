class Snippet {
  final String id;
  final String userId;
  final String imageURL;
  final int score;

  Snippet(this.id, this.userId, this.imageURL, this.score);
  Snippet.positional({ this.id, this.userId, this.imageURL, this.score });

  factory Snippet.empty() {
    return Snippet('', '', '', -1);
  }

  factory Snippet.fromJson(Map json) {
    return Snippet.positional(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      imageURL: json['imageURL'] ?? '',
      score: json['score'] ?? -1,
    );
  }

  Map<String, dynamic> toJson(Snippet snippet) {
    return {
      '_id': snippet.id,
      'userId': snippet.userId,
      'imageURL': snippet.imageURL,
      'score': snippet.score,
    };
  }
}