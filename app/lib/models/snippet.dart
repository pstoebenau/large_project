class User {
  final String id;
  final String userID;
  final String imageURL;
  final String score;

  User(this.id, this.userID, this.imageURL, this.score);

  User.fromJson(Map<String, dynamic> json)
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