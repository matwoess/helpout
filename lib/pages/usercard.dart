import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:helpout/model/user.dart';

class UserCard extends Card {
  final User _user;
  final Function _detailsCallback;

  UserCard(this._user, this._detailsCallback);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12.0),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              '${_user.name}',
              style: Theme.of(context).textTheme.headline6,
            ),
            leading: Image(image: AssetImage(_user.assetURI)),
            subtitle: Text(
              '${_user.region}',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "${_user.description}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 10,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () => _detailsCallback(_user),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Details',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
