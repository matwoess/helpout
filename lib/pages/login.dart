import 'package:flutter/material.dart';
import 'package:helpout/misc/dbmanager.dart';

import '../model/appstate.dart';

class LogInPage extends StatelessWidget {
  LogInPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Log in'),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: LogInForm(),
          ),
        ),
      ),
    );
  }
}

class LogInForm extends StatefulWidget {
  LogInForm();

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool _passwordDoesNotMatch = false;
  String _pw = 'pw';

  double _formProgress = 0;

  void _updateFormProgress() {
    var progress = 0.0;
    var controllers = [
      _usernameTextController,
      _passwordTextController,
    ];

    for (var controller in controllers) {
      if (controller == _passwordTextController &&
          _passwordDoesNotMatch &&
          _passwordTextController.text != '') {
        _passwordDoesNotMatch = false;
      }
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

  void _showWelcomeScreen() async {
    if (_passwordTextController.text != _pw) {
      _passwordDoesNotMatch = true;
      setState(() {
        _passwordTextController.text = '';
      });
      return;
    }
    AppState.getInstance().accountData = await DBManager.getMyAccount();
    Navigator.popAndPushNamed(context, '/login/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: _updateFormProgress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedProgressIndicator(value: _formProgress),
          Text('Log in', style: Theme.of(context).textTheme.headline4),
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
          Visibility(
            visible: _passwordDoesNotMatch,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Password did not match!',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateColor.resolveWith((Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : Colors.white;
                }),
                backgroundColor:
                    MaterialStateColor.resolveWith((Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : Colors.blue;
                }),
              ),
              onPressed: _formProgress == 1 ? _showWelcomeScreen : null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Log in', style: TextStyle(fontSize: 20.0),),
              ),
            ),
          ),
        ],
      ),
    );
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

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colorAnimation;
  Animation<double> _curveAnimation;

  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1200), vsync: this);

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
