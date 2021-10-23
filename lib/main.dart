// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String equation ="0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;


  void _buttonPressed(String buttonText) {
    setState(() {
      if(buttonText == "C"){
        equation='0';
        result='0';
        equationFontSize = 38.0;
        resultFontSize = 48.0;

      }else if(buttonText == "⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0,equation.length-1);
        if(equation == ""){
          equation = "0";
        }

      }else if(buttonText == "=" ){
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');
        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';



        }catch(e){
          result = "Invalid";
        }

      }else{
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        if(equation == "0"){
          equation = buttonText;
        }else{

        equation= equation + buttonText;
        }
      }
    });

  }

  Widget _buildButton(String buttonText,Color buttonColor) {
    return Container(
      margin: EdgeInsets.all(3),
      height: MediaQuery.of(context).size.height * .1 ,
      //color: buttonColor,
      child: TextButton(
        onPressed: () {
          _buttonPressed(buttonText);
        },
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.normal,
            color: buttonColor,
          ),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
              color: Colors.white,
              width: 6,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(
                fontSize: equationFontSize,
                color: Colors.deepOrange[400],
              ),
            ),
          ),
          Container(
            //height: MediaQuery.of(context).size.height * .2,
            alignment: Alignment.centerRight,
            //padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(" = "+
              result,
              style: TextStyle(
                fontSize: resultFontSize,
                color: Colors.pink,
              ),
            ),
          ),
           Expanded(child: Divider(thickness: 0.0,
           //indent: 0.0,
           endIndent: MediaQuery.of(context).size.width,
           )
           ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        _buildButton("C" , Colors.orangeAccent),
                        _buildButton("⌫", Colors.red),
                        _buildButton("÷", Colors.orangeAccent),
                        _buildButton("x", Colors.orangeAccent),
                      ],
                    ),
      
                    TableRow(
                      children: [
                        _buildButton("7", Colors.blue),
                        _buildButton("8", Colors.blue),
                        _buildButton("9", Colors.blue),
                         _buildButton("-", Colors.redAccent),
                      ],
                    ),
      
                    TableRow(
                      children: [
                        _buildButton("4", Colors.blue),
                        _buildButton("5", Colors.blue),
                        _buildButton("6", Colors.blue),
                         _buildButton("+", Colors.redAccent),
                      ],
                    ),
      
                    TableRow(
                      children: [
                        _buildButton("1", Colors.blue),
                        _buildButton("2", Colors.blue),
                        _buildButton("3", Colors.blue),
                         _buildButton("%", Colors.orangeAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildButton(".", Colors.black54),
                        _buildButton("0", Colors.blue),
                        _buildButton("00", Colors.blue),
                        _buildButton("=", Colors.greenAccent)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
