class Post {
  final String userEmail;
  final String fullName;
  final String currAdd;
  final String currCountry;
  final String currState;
  final String currCity;
  final String currZip;
  final String destAdd;
  final String destCountry;
  final String destState;
  final String destCity;
  final String destZip;

  Post(
      {this.userEmail,
      this.fullName,
      this.currAdd,
      this.currCountry,
      this.currState,
      this.currCity,
      this.currZip,
      this.destAdd,
      this.destCountry,
      this.destState,
      this.destCity,
      this.destZip});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userEmail: json['userEmail'] as String,
      fullName: json['fullName'] as String,
      currAdd: json['currAdd'] as String,
      currCountry: json['currCountry'] as String,
      currState: json['currState'] as String,
      currCity: json['currCity'] as String,
      currZip: json['currZip'] as String,
      destAdd: json['destAdd'] as String,
      destCountry: json['destCountry'] as String,
      destState: json['destState'] as String,
      destZip: json['destZip'] as String,
    );
  }
}
