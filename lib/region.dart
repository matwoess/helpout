class Region {
  String name;
  final Location location;

  Region(this.name, this.location);

  Region.withoutLocation(String name)
      : this.name = name,
        this.location = Location.unknown();

  @override
  String toString() {
    return name;
  }
}

class Location {
  double lat;
  double long;

  Location(this.lat, this.long);

  Location.unknown() : this(0.0, 0.0);
}
