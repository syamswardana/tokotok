class Address {
  final String id;
  final String name;
  final String noTelp;
  final String provinsi;
  final String address;

  Address({this.id, this.name, this.noTelp, this.provinsi, this.address});

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "noTelp": this.noTelp,
      "provinsi": this.provinsi,
      "address": this.address
    };
  }
}
