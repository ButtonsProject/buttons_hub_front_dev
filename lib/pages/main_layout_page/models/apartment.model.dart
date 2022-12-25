class Apartment {
  int apartID;
  String name;
  String address;
  String imgUrl;
  DateTime startRentTime;
  DateTime endRentTime;

  Apartment(
      this.apartID,
      this.name,
      this.address,
      this.imgUrl,
      this.startRentTime,
      this.endRentTime);

  factory Apartment.fromJson(Map<String, dynamic> json){
    return Apartment(
        json['apartment']['id'],
        json['apartment']['name'].toString(),
        json['apartment']['address'].toString(),
        json['apartment']['imgUrl'].toString() == 'null'
            ? 'assets/images/kover2.png'
            :  json['apartment']['imgUrl'].toString() ,
        DateTime.parse(json['startTimeRent']),
        DateTime.parse(json['endTimeRent'])
    );
  }
}
