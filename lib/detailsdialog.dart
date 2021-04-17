import 'package:flutter/material.dart';

import 'constants.dart';
import 'person.dart';

class DetailsDialog extends StatelessWidget {
  final Person _person;
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
                    child: Text(
                      'Start Chat',
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
