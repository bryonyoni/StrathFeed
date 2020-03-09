class Location {
  final String name;
  final String email;
  final String areaClass;
  static Location location;

  Location(this.name, this.email, this.areaClass);

  Location.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        areaClass = json['areaClass'],
        email = json['email'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'areaClass': areaClass,
        'email': email,
      };
}
