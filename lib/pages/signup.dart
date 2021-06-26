import 'package:flutter/material.dart';
import 'package:helpout/misc/dbmanager.dart';
import 'package:helpout/model/region.dart';
import 'package:helpout/model/user.dart';
import 'package:helpout/util/locator.dart';

import '../model/appstate.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  SignUpForm();

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _repeatpwTextController = TextEditingController();
  bool _passwordDoesNotMatch = false;

  // for additional settings
  var _tapPosition;
  String _assetURI = 'assets/images/empty.png';
  int _price = 0;
  Region _region = null;
  Gender _gender = Gender.UNKNOWN;

  Future<List<Region>> regions;

  @override
  void initState() {
    regions = getRegions();
    super.initState();
  }

  double _formProgress = 0;

  void _updateFormProgress() {
    var progress = 0.0;
    var controllers = [
      _firstNameTextController,
      _lastNameTextController,
      _usernameTextController,
      _passwordTextController,
      _repeatpwTextController,
    ];

    for (var controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        if (controller == _passwordTextController || controller == _repeatpwTextController) {
          if (_passwordTextController.text != _repeatpwTextController.text) {
            _passwordDoesNotMatch = true;
            continue;
          } else {
            _passwordDoesNotMatch = false;
          }
        }
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

  void _showWelcomeScreen() async {
    User user = await DBManager.createUser(_firstNameTextController.text, _lastNameTextController.text,
        _usernameTextController.text, _passwordTextController.text, _region, _gender, _assetURI, _price);
    AppState.getInstance().accountData = user;
    Navigator.popAndPushNamed(context, '/signup/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: _updateFormProgress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedProgressIndicator(value: _formProgress),
          Text('Sign up', style: Theme.of(context).textTheme.headline4),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _firstNameTextController,
              decoration: InputDecoration(hintText: 'First name'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _lastNameTextController,
              decoration: InputDecoration(hintText: 'Last name'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _usernameTextController,
              decoration: InputDecoration(hintText: 'Username'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _passwordTextController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _repeatpwTextController,
              decoration: InputDecoration(hintText: 'Repeat password'),
            ),
          ),
          Visibility(
            visible: _passwordDoesNotMatch,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Passwords do not match!',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
            child: Text('Additional user settings:'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<Region>>(
              future: regions,
              builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                return Row(
                  children: [
                    Text('Residence:'),
                    SizedBox(width: 15),
                    Expanded(child: Container()),
                    DropdownButton<Region>(
                      //isExpanded: true,
                      value: _region,
                      onChanged: (Region newValue) {
                        setState(() {
                          _region = newValue;
                        });
                      },
                      underline: Container(
                        height: 2,
                        color: Theme.of(context).accentColor,
                      ),
                      items: snapshot.connectionState == ConnectionState.waiting
                          ? null
                          : snapshot.data
                              .map((r) => DropdownMenuItem<Region>(
                                    child: Text(r.toString()),
                                    value: r,
                                  ))
                              .toList(),
                      hint: snapshot.connectionState == ConnectionState.waiting
                          ? Text('Getting available regions')
                          : Text('Select region'),
                    ),
                    Visibility(
                      visible: snapshot.connectionState != ConnectionState.waiting,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton(
                          onPressed: getOrCreateRegion,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.my_location),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Gender:'),
                Expanded(
                  child: Container(),
                ),
                DropdownButton<Gender>(
                  value: _gender,
                  onChanged: (Gender newValue) {
                    setState(() {
                      _gender = newValue;
                    });
                  },
                  underline: Container(
                    height: 2,
                    color: Theme.of(context).accentColor,
                  ),
                  items: Gender.values.map<DropdownMenuItem<Gender>>((Gender value) {
                    return DropdownMenuItem<Gender>(
                      value: value,
                      child: Text(value.toShortString()),
                    );
                  }).toList(),
                ),
                SizedBox(width: 16.0),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Profile picture:'),
                Expanded(child: Container()),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Theme.of(context).accentColor),
                    ),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: CircleAvatar(
                          child: Image(image: AssetImage(_assetURI)),
                          maxRadius: 20,
                        ),
                        onTap: showImagePicker,
                        onTapDown: storeTapPosition,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('${_assetURI.split('/').last}'),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Price per hour for helping out:'),
                Expanded(
                  child: Container(),
                ),
                DropdownButton<int>(
                  value: _price,
                  onChanged: (int newValue) {
                    setState(() {
                      _price = newValue;
                    });
                  },
                  underline: Container(
                    height: 2,
                    color: Theme.of(context).accentColor,
                  ),
                  items: Iterable<int>.generate(15 + 1).map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString() + '€'),
                    );
                  }).toList(),
                ),
                SizedBox(width: 16.0),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled) ? null : Colors.white;
                }),
                backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled) ? null : Colors.blue;
                }),
              ),
              onPressed: _formProgress == 1 ? _showWelcomeScreen : null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  storeTapPosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void showImagePicker() {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    RelativeRect rect = RelativeRect.fromRect(_tapPosition & const Size(40, 40), Offset.zero & overlay.size);
    //TODO: read from avatars folder
    List<String> allAvatars = [
      'assets/avatars/female1.png',
      'assets/avatars/female2.png',
      'assets/avatars/female3.png',
      'assets/avatars/female4.png',
      'assets/avatars/male1.png',
      'assets/avatars/male2.png',
      'assets/avatars/male3.png',
    ];
    List<PopupMenuItem<String>> menuItems = allAvatars
        .map(
          (avatar) => PopupMenuItem(
            value: avatar,
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  child: Image(image: AssetImage(avatar)),
                  maxRadius: 20,
                ),
                SizedBox(width: 5),
                Text('${avatar.split('/').last}'),
              ],
            ),
          ),
        )
        .toList();
    showMenu(
      context: context,
      position: rect,
      items: menuItems,
    ).then<void>((String pickedAvatar) {
      if (pickedAvatar == null) return;
      _assetURI = pickedAvatar;
      setState(() {});
    });
  }

  static Future<List<Region>> getRegions() async {
    List<Region> regions = await DBManager.getAvailableRegions();
    return regions;
  }

  void getOrCreateRegion() async {
    Region region = await Locator.getWhereabouts(create: true);
    print('got ' + region.toString());
    await regions.then((regions) => {if (!regions.contains(region)) regions.add(region)});
    setState(() {
      _region = region;
    });
  }
}

class AnimatedProgressIndicator extends StatefulWidget {
  final double value;

  AnimatedProgressIndicator({
    @required this.value,
  });

  @override
  State<StatefulWidget> createState() {
    return _AnimatedProgressIndicatorState();
  }
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colorAnimation;
  Animation<double> _curveAnimation;

  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 1200), vsync: this);

    var colorTween = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.orange),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.orange, end: Colors.yellow),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 1,
      ),
    ]);

    _colorAnimation = _controller.drive(colorTween);
    _curveAnimation = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => LinearProgressIndicator(
        value: _curveAnimation.value,
        valueColor: _colorAnimation,
        backgroundColor: _colorAnimation.value.withOpacity(0.4),
      ),
    );
  }
}
