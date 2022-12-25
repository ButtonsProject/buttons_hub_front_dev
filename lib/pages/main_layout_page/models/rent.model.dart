class Rent {
  int rentId;

  Rent(this.rentId);

  factory Rent.fromJson(Map<String, dynamic> json) {
    return Rent(json['id']);
  }
}
