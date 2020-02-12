class Location {
  final String name;
  final String email;

  Location(this.name, this.email);

  Location.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'email': email,
      };
}
