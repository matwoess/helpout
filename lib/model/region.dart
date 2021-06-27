class Region {
  static Region unknown = Region('....', 'unknown');
  String postcode;
  String city;

  Region(this.postcode, this.city);

  @override
  String toString() {
    return postcode + ', ' + city;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Region && runtimeType == other.runtimeType && postcode == other.postcode && city == other.city;

  @override
  int get hashCode => postcode.hashCode ^ city.hashCode;

  static Region fromJson(Map<String, dynamic> json, List<Region> regions, bool create) {
    String postcode = json['results'][0]['components']['postcode'];
    // alternative if not used in response
    if (postcode == null) {
      postcode = json['results'][0]['components']['partial_postcode'];
    }
    String city = json['results'][0]['components']['city'];
    // alternative if not used in response
    if (city == null) {
      city = json['results'][0]['components']['town'];
    }
    if (city == null) {
      city = json['results'][0]['components']['township'];
    }
    for (Region r in regions) {
      if (r.postcode == postcode && r.city == city) {
        return r;
      }
    }
    if (create)
      return Region(postcode, city);
    else
      return unknown;
  }
}
