import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:helpout/person.dart';

class PersonCard extends Card {
  Person _person;
  Function detailsCallback = () {};

  PersonCard(this._person, this.detailsCallback);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12.0),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title: Text('${_person.name}'),
            leading: Image(image: AssetImage("assets/images/empty.png")),
            subtitle: Text(
              '${_person.region}',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "${_person.description}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 10,
                  ),
                ),
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () => detailsCallback(),
                child: const Text('DETAILS'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
