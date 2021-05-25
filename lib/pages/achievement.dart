import 'package:flutter/material.dart';
import 'package:helpout/model/appstate.dart';
import 'package:helpout/model/user.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AchievementPage extends StatefulWidget {
  @override
  _AchievementPageState createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  final User accountData = AppState.getInstance().accountData;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            color: Theme.of(context).canvasColor,
            child: Container(
          width: double.infinity,
          height: 400.0,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Level:',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 28.0),
                ),
                Text(
                  accountData.level.toString(),
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Your social virtues:',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor, fontSize: 28.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: new LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 100,
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: 20.0,
                          percent: 0.7,
                          center: Text(
                            "70.0%",
                            style: new TextStyle(fontSize: 14.0),
                          ),
                          trailing: Text("Kindness"),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          backgroundColor: Colors.grey,
                          progressColor: Colors.pink,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: new LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 100,
                          trailing: Text("Gratitude"),
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 1000,
                          percent: 0.9,
                          center: Text(
                            "90.0%",
                            style: new TextStyle(fontSize: 14.0),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.orangeAccent,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: new LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 100,
                          trailing: Text("Generosity"),
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 1000,
                          percent: 0.8,
                          center: Text(
                            "80.0%",
                            style: new TextStyle(fontSize: 14.0),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.lightGreen,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: new LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 100,
                          trailing: Text("Experience"),
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 1000,
                          percent: 0.8,
                          center: Text(
                            "80.0%",
                            style: new TextStyle(fontSize: 14.0),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.cyan,
                        ),
                      ),
                    ],
                  ),
                ),
              ])))),
        Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Badges:',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 28.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "All the great things you have achieved",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Badge 1',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          CircleAvatar(
                            child: Image(
                                image: AssetImage(
                                    "assets/images/achievement_mountain.png")),
                            radius: 50.0,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Badge 2',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          CircleAvatar(
                            child: Image(
                                image: AssetImage(
                                    "assets/images/achievement_steps.png")),
                            radius: 50.0,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Badge 3',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          CircleAvatar(
                            child: Image(
                                image: AssetImage(
                                    "assets/images/achievement_trophy.png")),
                            radius: 50.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
