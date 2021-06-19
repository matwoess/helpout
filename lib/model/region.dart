class Region {
  static Region unknown = Region('0000', 'unknown');
  String postcode;
  String city;

  Region(this.postcode, this.city);

  @override
  String toString() {
    return postcode + ', ' + city;
  }

  @override
  bool operator ==(o) => o is Region && o.city == city && o.postcode == postcode;

  static Region fromJson(Map<String, dynamic> json, List<Region> regions) {
    String postcode = json['results'][0]['components']['postcode'];
    String city = json['results'][0]['components']['city'];
    for (Region r in regions) {
      if (r.postcode == postcode && r.city == city) {
        return r;
      }
    }
    return unknown;
  }
}
