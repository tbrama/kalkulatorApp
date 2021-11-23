import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kalkulator',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = "";
  String result = "";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "";
        result = "";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if(buttonText == "⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(buttonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '/100');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }

      else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color textColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.all(16.0),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: textColor
            ),
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Kalkulator', style: TextStyle(color: Colors.white)), backgroundColor: Colors.black,),
      body: Column(
        children: <Widget>[
          Container(
            
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, 
              style: TextStyle(
                fontSize: equationFontSize,
                color: Colors.white
                ),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, 
              style: TextStyle(
                fontSize: resultFontSize,
                color: Colors.teal.shade300),),
          ),


          Expanded(
            child: Divider(),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.teal.shade300),
                        buildButton("⌫", 1, Colors.teal.shade300),
                        buildButton("÷", 1, Colors.teal.shade300),
                      ]
                    ),

                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.white70),
                          buildButton("8", 1, Colors.white70),
                          buildButton("9", 1, Colors.white70),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.white70),
                          buildButton("5", 1, Colors.white70),
                          buildButton("6", 1, Colors.white70),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.white70),
                          buildButton("2", 1, Colors.white70),
                          buildButton("3", 1, Colors.white70),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton(".", 1, Colors.white70),
                          buildButton("0", 1, Colors.white70),
                          buildButton("00", 1, Colors.white70),
                        ]
                    ),
                  ],
                ),
              ),


              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("×", 1, Colors.teal.shade300),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.teal.shade300),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.teal.shade300),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("%", 1, Colors.teal.shade300),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 1, Colors.teal.shade300),
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}