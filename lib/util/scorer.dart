import 'package:flutter/material.dart';

class Scorer extends StatelessWidget {
  final int score;
  final String type;
  final String userId;

  Scorer(this.score, this.type, this.userId);

 // TODO
  int getScore(String userId) {
    // SELECT user's score from database
    return score;
  }

  // TODO
  updateScore(String userId) {
    // UPDATE user's score in database
  }

  // TODO
  updateLevel(String userId) {
    // UPDATE user's level in database
  }

  double get calculateResult {
    double result = -1;

    if (type == "virtue") {
      if (0 <= score && score <= 100) {
        result = score / 100;
      } else if (100 < score && score <= 200) {
        result = score / 200;
      } else if (200 < score && score <= 300) {
        result = score / 300;
      } else if (300 < score && score <= 400) {
        result = score / 400;
      } else if (400 < score && score <= 500) {
        result = score / 500;
      } else if (score > 500) {
        result = 1.00;
      }
    } else if (type == "level") {
      if (0 <= score && score <= 100) {
        result = 1;
      } else if (100 < score && score <= 200) {
        result = 2;
      } else if (200 < score && score <= 300) {
        result = 3;
      } else if (300 < score && score <= 400) {
        result = 4;
      } else if (400 < score && score <= 500) {
        result = 5;
      } else if (score > 500) {
        result = 6;
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return (type == "virtue")
        ? Text(calculateResult.toStringAsFixed(2))
        : (type == "level")
            ? Text(calculateResult.toStringAsFixed(0))
            : const Text("Invalid result");
  }
}
