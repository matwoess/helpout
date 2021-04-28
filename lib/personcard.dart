import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:helpout/person.dart';

class PersonCard extends Card {
  final Person _person;
  final Function _detailsCallback;

  PersonCard(this._person, this._detailsCallback);

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
            leading: Image(image: AssetImage(_person.assetURI)),
            subtitle: Text(
              '${_person.region}',
              style: Theme.of(context).textTheme.bodyText2,
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
                onPressed: () => _detailsCallback(_person),
                child: const Text('Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
