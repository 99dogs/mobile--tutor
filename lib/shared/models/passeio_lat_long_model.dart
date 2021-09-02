class PasseioLatLongModel {
  String latitude = "";
  String longitude = "";
  PasseioLatLongModel({
    required this.latitude,
    required this.longitude,
  });

  PasseioLatLongModel copyWith({
    String? latitude,
    String? longitude,
  }) {
    return PasseioLatLongModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory PasseioLatLongModel.fromMap(Map<String, dynamic> map) {
    return PasseioLatLongModel(
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  PasseioLatLongModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }

  @override
  String toString() =>
      'PasseioLatLongModel(latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PasseioLatLongModel &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
