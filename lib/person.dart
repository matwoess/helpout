import 'package:helpout/region.dart';

class Person {
  final Region region;
  final String name;
  final int price;
  final String description;

  Person(
    this.name,
    this.region,
    this.price,
    this.description,
  );

  Person.loading() : this('...', Region.withoutLocation("unknown"), 0, "...");

  bool get isLoading => name == '...';
}
