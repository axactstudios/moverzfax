class Post {
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
      {this.fullName,
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
      fullName: json['fullName'] as String,
      currAdd: json['currAdd'] as String,
      currCountry: json['currDropdownValue'] as String,
      currState: json['currDropdownValue1'] as String,
      currCity: json['currDropdownValue2'] as String,
      currZip: json['currZip'] as String,
      destAdd: json['destDropdownValue'] as String,
      destCountry: json['destDropdownValue1'] as String,
      destState: json['destDropdownValue2'] as String,
      destZip: json['moverZipCode'] as String,
    );
  }
}
