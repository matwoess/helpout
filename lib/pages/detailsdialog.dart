import 'package:flutter/material.dart';

import '../misc/constants.dart';
import '../model/user.dart';

class DetailsDialog extends StatelessWidget {
  final User _person;
  final Function _chatCallback;

  DetailsDialog(this._person, this._chatCallback);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      clipBehavior: Clip.antiAlias,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.detailDialogPadding,
              top: Constants.detailDialogAvatarRadius + Constants.detailDialogPadding,
              right: Constants.detailDialogPadding,
              bottom: Constants.detailDialogPadding),
          margin: EdgeInsets.only(top: Constants.detailDialogAvatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(Constants.detailDialogPadding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                _person.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                '${_person.region}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                _person.description,
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 22.0,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () => _chatCallback(_person),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Start Chat',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.detailDialogPadding,
          right: Constants.detailDialogPadding,
          child: CircleAvatar(
            radius: Constants.detailDialogAvatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.detailDialogAvatarRadius)),
                child: Image(image: AssetImage(_person.assetURI))),
          ),
        ),
      ],
    );
  }
}
