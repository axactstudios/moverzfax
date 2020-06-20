class Mover {
  final String moverName;
  final String moverUSDOTNo;
  final String moverPhno;
  final String moverRating;
  final String moverMCNo;
  final String moverDescription;

  Mover(
      {this.moverName,
      this.moverUSDOTNo,
      this.moverPhno,
      this.moverRating,
      this.moverMCNo,
      this.moverDescription});

  factory Mover.fromJson(Map<String, dynamic> json) {
    return Mover(
      moverName: json['moverName'] as String,
      moverDescription: json['moverDescription'] as String,
      moverUSDOTNo: json['moverUSDOTNo'] as String,
      moverMCNo: json['moverMCNo'] as String,
      moverRating: json['moverRating'] as String,
      moverPhno: json['moverPhno'] as String,
    );
  }
}
