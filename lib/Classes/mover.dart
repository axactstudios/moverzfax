class Mover {
  final String moverName;
  final String moverUSDOTNo;
  final String moverPhno;
  final String moverRating;
  final String moverMCNo;
  final String moverDescription;
  final String moverZipCode;
  final String moverCountry;
  final String moverCity;
  final String moverState;

  Mover(
      {this.moverName,
      this.moverUSDOTNo,
      this.moverPhno,
      this.moverRating,
      this.moverMCNo,
      this.moverDescription,
      this.moverCountry,
      this.moverState,
      this.moverCity,
      this.moverZipCode});

  factory Mover.fromJson(Map<String, dynamic> json) {
    return Mover(
      moverName: json['moverName'] as String,
      moverDescription: json['moverDescription'] as String,
      moverUSDOTNo: json['moverUSDOTNo'] as String,
      moverMCNo: json['moverMCNo'] as String,
      moverRating: json['moverRating'] as String,
      moverPhno: json['moverPhno'] as String,
      moverCountry: json['moverCountry'] as String,
      moverState: json['moverState'] as String,
      moverCity: json['moverCity'] as String,
      moverZipCode: json['moverZipCode'] as String,
    );
  }
}
