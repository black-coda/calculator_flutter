// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:calculator_flutter/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> buttonText = [
    "C",
    "Del",
    "%",
    "/",
    "9",
    "8",
    "7",
    "X",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];
  bool isOperator(String x) {
    if (x == "X" || x == "-" || x == "+" || x == "=" || x == "%" || x == "/") {
      return true;
    } else {
      return false;
    }
  }

  var userQuestion = '';
  var userAnswer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1A1B28),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              // flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: const TextStyle(color: Colors.white, fontSize: 29),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  // mainAxisSpacing: 0.0,
                  // crossAxisSpacing: 0.0,
                  // childAspectRatio: 1.1,
                ),
                itemCount: buttonText.length,
                itemBuilder: (BuildContext context, int index) {
                  // clear button
                  if (index == 0) {
                    return MyButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      buttonText: buttonText[index],
                      buttonTapped: () {
                        setState(() {
                          userQuestion = " ";
                          if (userAnswer != "") {
                            userAnswer = "";
                          }
                        });
                      },
                    );
                  } else if (index == 1) {
                    return MyButton(
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      buttonText: buttonText[index],
                      buttonTapped: () {
                        setState(() {
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                        });
                      },
                    );
                  } else if (index == buttonText.length - 1) {
                    return MyButton(
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      buttonText: buttonText[index],
                      buttonTapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                    );
                  } else if (index == buttonText.length - 2) {
                    return MyButton(
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      buttonText: buttonText[index],
                      buttonTapped: () {
                        setState(() {
                          buttonText[buttonText.length - 2] =
                              userAnswer.toString();
                          print(buttonText[buttonText.length - 2]);

                          // TODO To Fix ANS button
                        });
                      },
                    );
                  } else {
                    return MyButton(
                      color: isOperator(buttonText[index])
                          ? Colors.red
                          : const Color(0xfff2E303B),
                      textColor: Colors.white,
                      buttonText: buttonText[index],
                      buttonTapped: () {
                        setState(() {
                          userQuestion += buttonText[index];
                        });
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void equalPressed() {
    String questionToSolve = userQuestion;

    questionToSolve = questionToSolve.replaceAll("X", "*");

    Parser p = Parser();
    Expression exp = p.parse(questionToSolve);
    exp.simplify();
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
