import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      title: 'Dice Throw',
      home: DiceThrow(),
    );
  }
}

class DiceThrow extends StatefulWidget {
  @override
  _DiceThrowState createState() => _DiceThrowState();
}

class _DiceThrowState extends State<DiceThrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late List<int> _diceOneValues;
  late List<int> _diceTwoValues;
  int _diceOneValue = 1;
  int _diceTwoValue = 1;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn);
    _diceOneValues = List.generate(6, (index) => index + 1);
    _diceTwoValues = List.generate(6, (index) => index + 1);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _rollDice() {
    setState(() {
      _diceOneValue = Random().nextInt(6) + 1;
      _diceTwoValue = Random().nextInt(6) + 1;
      _diceOneValues.shuffle();
      _diceTwoValues.shuffle();
    });

    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onDoubleTap: _rollDice,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget? child) {
                  int diceValue = _diceOneValues.isEmpty
                      ? _diceOneValue
                      : _diceOneValues.first;
                  return Visibility(
                    visible: _animation.status == AnimationStatus.completed,
                    replacement: Transform.rotate(
                      angle: _animation.value * pi * 2,
                      child: Image.asset(
                        'assets/images/dice${Random().nextInt(6) + 1}.png',
                        height: 150,
                        width: 150,
                      ),
                    ),
                    child: Transform.rotate(
                      angle: _animation.value * pi * 2,
                      child: Image.asset(
                        'assets/images/dice$diceValue.png',
                        height: 150,
                        width: 150,
                      ),
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget? child) {
                  int diceValue = _diceTwoValues.isEmpty
                      ? _diceTwoValue
                      : _diceTwoValues.first;
                  return Visibility(
                    visible: _animation.status == AnimationStatus.completed,
                    replacement: Transform.rotate(
                      angle: _animation.value * pi * 2,
                      child: Image.asset(
                        'assets/images/dice${Random().nextInt(6) + 1}.png',
                        height: 150,
                        width: 150,
                      ),
                    ),
                    child: Transform.rotate(
                      angle: _animation.value * pi * 2,
                      child: Image.asset(
                        'assets/images/dice$diceValue.png',
                        height: 150,
                        width: 150,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
