import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:sci_calc/button.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator>
    with SingleTickerProviderStateMixin {
  String equation = "";
  String result = "";
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  void _addToEquation(String text) {
    setState(() {
      equation += text;
    });
  }

  void _calculateResult() {
    Parser p = Parser();
    Expression exp = p.parse(equation);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      result = eval.toString();
    });
  }

  void _clear() {
    setState(() {
      equation = '';
      result = '';
    });
  }

  void _performScientificFunction(String function) {
    setState(() {
      equation += function;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 18, 18),
      appBar: AppBar(
        title: Text(
          "Scientific Calculator",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        bottom: TabBar(controller: tabController, tabs: [
          Tab(
            child: Text(
              "Basic",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Tab(
            child: Text(
              "Scientific",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )
        ]),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: TabBarView(controller: tabController, children: [
        // Tab 1 Basic...
        Column(
          children: [
            // Read and Write Panel Screen...
            Expanded(
                child: Container(
              width: double.infinity,
              color: Colors.blueGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    child: Math.tex(
                      equation,
                      textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(16.0),
                    child: Math.tex(
                      result,
                      textStyle:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )),
            // History and other scientific functional panel...

            // Buttons or functions Panel Screen...
            Row(
              children: [
                Button(
                    text: "AC",
                    onPress: () => _clear(),
                    textColor: Colors.blueGrey),
                Button(
                    text: "(",
                    onPress: () => _addToEquation('('),
                    textColor: Colors.white),
                Button(
                    text: ")",
                    onPress: () => _addToEquation(")"),
                    textColor: Colors.white),
                Button(
                    text: "mod",
                    onPress: () => _addToEquation("%"),
                    textColor: Colors.white)
              ],
            ),
            Row(
              children: [
                Button(
                    text: "7",
                    onPress: () => _addToEquation("7"),
                    textColor: Colors.white),
                Button(
                    text: "8",
                    onPress: () => _addToEquation("8"),
                    textColor: Colors.white),
                Button(
                    text: "9",
                    onPress: () => _addToEquation("9"),
                    textColor: Colors.white),
                Button(
                    text: "/",
                    onPress: () => _addToEquation('/'),
                    textColor: Colors.blueGrey),
              ],
            ),
            Row(
              children: [
                Button(
                    text: "4",
                    onPress: () => _addToEquation("4"),
                    textColor: Colors.white),
                Button(
                    text: "5",
                    onPress: () => _addToEquation('5'),
                    textColor: Colors.white),
                Button(
                    text: "6",
                    onPress: () => _addToEquation("6"),
                    textColor: Colors.white),
                Button(
                    text: "x",
                    onPress: () => _addToEquation('*'),
                    textColor: Colors.white)
              ],
            ),
            Row(
              children: [
                Button(
                    text: "1",
                    onPress: () => _addToEquation("1"),
                    textColor: Colors.white),
                Button(
                    text: "2",
                    onPress: () => _addToEquation("2"),
                    textColor: Colors.white),
                Button(
                    text: "3",
                    onPress: () => _addToEquation("3"),
                    textColor: Colors.white),
                Button(
                    text: "-",
                    onPress: () => _addToEquation('-'),
                    textColor: Colors.white)
              ],
            ),
            Row(
              children: [
                Button(
                    text: ".",
                    onPress: () => _addToEquation('.'),
                    textColor: Colors.white),
                Button(
                    text: "0",
                    onPress: () => _addToEquation("0"),
                    textColor: Colors.white),
                Button(
                    text: "=",
                    onPress: () => _calculateResult(),
                    textColor: Colors.blueGrey),
                Button(
                    text: "+",
                    onPress: () => _addToEquation("+"),
                    textColor: Colors.white)
              ],
            ),
          ],
        ),
        // Tab 2 Scientific Calculator...
        Column(
          children: [
            // Read and Write Panel Screen...
            Expanded(
                child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  tabController!.animateTo(0);
                } else if (details.delta.dx < 0) {
                  tabController!.animateTo(1);
                }
              },
              child: Container(
                width: double.infinity,
                color: Colors.blueGrey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SingleChildScrollView(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      child: Math.tex(
                        equation,
                        textStyle: TextStyle(
                          fontSize: 50,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.all(16.0),
                      child: Math.tex(
                        result,
                        textStyle: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            // History and other scientific functional panel...

            // Buttons or functions Panel Screen...
            Row(
              children: [
                Button(
                    text: "AC",
                    onPress: () => _clear(),
                    textColor: Colors.white),
                Button(
                    text: "=",
                    onPress: () => _CalculatorState(),
                    textColor: Colors.white),
                Button(
                    text: "Cos(",
                    onPress: () => _performScientificFunction('cos('),
                    textColor: Colors.white),
                Button(
                    text: "Sin(",
                    onPress: () => _performScientificFunction('sin('),
                    textColor: Colors.blueGrey),
              ],
            ),
            Row(
              children: [
                Button(
                    text: "√",
                    onPress: () => _performScientificFunction('sqrt('),
                    textColor: Colors.white),
                Button(
                    text: "^",
                    onPress: () => _performScientificFunction('^'),
                    textColor: Colors.white),
                Button(
                    text: "log",
                    onPress: () => _performScientificFunction('log('),
                    textColor: Colors.white),
                Button(
                    text: "tan(",
                    onPress: () => _performScientificFunction('tan('),
                    textColor: Colors.blueGrey),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
