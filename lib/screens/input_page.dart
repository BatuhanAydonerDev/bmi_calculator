import 'package:bmi_calculator/calculate_brain.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/components/round_icon_button.dart';
import 'package:bmi_calculator/screens/results_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/bottom_button.dart';
import '../constants.dart';
import '../components/reusable_card.dart';

enum GenderName { MALE, FEMALE }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Color _maleCardColor = kInactiveCardColor;
  Color _femaleCardColor = kInactiveCardColor;

  double _currentSliderValue = 180;
  int _weight = 60;
  int _age = 18;

  void _updateColor(GenderName gender) {
    _maleCardColor =
        (gender == GenderName.MALE) ? kActiveCardColor : kInactiveCardColor;
    _femaleCardColor =
        (gender == GenderName.FEMALE) ? kActiveCardColor : kInactiveCardColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI CALCULATOR"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    color: _maleCardColor,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.mars,
                      description: "MALE",
                    ),
                    onPress: () {
                      setState(() {
                        _updateColor(GenderName.MALE);
                      });
                    },
                  ),
                ),
                Expanded(
                    child: ReusableCard(
                  color: _femaleCardColor,
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.venus,
                    description: "FEMALE",
                  ),
                  onPress: () {
                    setState(() {
                      _updateColor(GenderName.FEMALE);
                    });
                  },
                )),
              ],
            ),
          ),
          Expanded(
              child: ReusableCard(
            color: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "HEIGHT",
                  style: kLabelTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      _currentSliderValue.round().toString(),
                      style: kNumberTextStyle,
                    ),
                    Text(
                      "cm",
                      style: kLabelTextStyle,
                    )
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      trackHeight: 1.0,
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                      thumbColor: Color(0xFFEB1555),
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Color(0xFF8D8E98)),
                  child: Slider(
                      value: _currentSliderValue,
                      min: 110,
                      max: 220,
                      divisions: 190,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      }),
                )
              ],
            ),
          )),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                    child: ReusableCard(
                  color: kActiveCardColor,
                  cardChild: Column(
                    children: <Widget>[
                      Text(
                        "WEIGHT",
                        style: kLabelTextStyle,
                      ),
                      Text(
                        _weight.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RoundIconButton(
                            iconData: FontAwesomeIcons.minus,
                            pressed: () {
                              setState(() {
                                _weight--;
                              });
                            },
                          ),
                          RoundIconButton(
                            iconData: FontAwesomeIcons.plus,
                            pressed: () {
                              setState(() {
                                _weight++;
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                )),
                Expanded(
                    child: ReusableCard(
                  color: kActiveCardColor,
                  cardChild: Column(
                    children: <Widget>[
                      Text(
                        "AGE",
                        style: kLabelTextStyle,
                      ),
                      Text(
                        _age.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RoundIconButton(
                            iconData: FontAwesomeIcons.minus,
                            pressed: () {
                              setState(() {
                                _age--;
                              });
                            },
                          ),
                          RoundIconButton(
                            iconData: FontAwesomeIcons.plus,
                            pressed: () {
                              setState(() {
                                _age++;
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          BottomButton(
            buttonTitle: "CALCULATE",
            page: () {
              CalculatorBrain calc = CalculatorBrain(
                  height: _currentSliderValue.toInt(), weight: _weight);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultsPage(
                            calculatorBrain: calc,
                          )));
            },
          ),
        ],
      ),
    );
  }
}
