import 'dart:io';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'MyCalc'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "0";
  String preOutput = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  buttonPressed(String buttonText){
    if(buttonText == "AC"){
       output = "0";
       preOutput = "0";
       num1 = 0.0;
       num2 = 0.0;
       operand = "";
    }
    else if (buttonText == "x" || buttonText == "/" || buttonText == "+" || buttonText == "-"){
      print(preOutput);
      num1 = double.parse(preOutput);
      preOutput = "0";
      operand = buttonText;
    }
    else if(buttonText == "."){   // checking if decimal
      if(preOutput.contains(".")){
        print('Already Contains Decimal');
      }
      else{
        preOutput = preOutput + buttonText;
      }
    }
    else if(buttonText == "="){
      num2 = double.parse(preOutput);
      preOutput = "";
      switch(operand) {
        case "+":
          preOutput = (num1 + num2).toString();
          break;
        case "-":
          preOutput = (num1 - num2).toString();
          break;
        case "x":
          preOutput = (num1 * num2).toString();
          break;
        case "/":
          preOutput = (num1 % num2).toString();
          break;
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    }
    else{   // for numbers
      preOutput = preOutput + buttonText;
      print(preOutput);
    }
    setState(() {
      output = double.parse(preOutput).toStringAsFixed(2);
    });
  }

  Widget BuildButton(String buttonText) {
    return Expanded(
      child: new OutlineButton(
        padding: new EdgeInsets.all(42.3),
        child: new Text(
          buttonText,
          style: new TextStyle(
            fontSize: 25.9,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => buttonPressed(buttonText),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new Container(
            child: new Column(
          children: <Widget>[
            Container(
              padding : new EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
            ),
                child: new Text(
                  output,
                  style:new TextStyle(fontSize: 90, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.centerRight
            ),
            new Expanded(
              child: new Divider(),
            ),
            Column(children: [
              Row(children: [
                BuildButton('AC'),
                BuildButton('<-'),
                BuildButton('%'),
                BuildButton('/'),
              ]),
              Row(children: [
                BuildButton('7'),
                BuildButton('8'),
                BuildButton('9'),
                BuildButton('x'),
              ]),
              Row(children: [
                BuildButton('4'),
                BuildButton('5'),
                BuildButton('6'),
                BuildButton('-'),
              ]),
              Row(children: [
                BuildButton('1'),
                BuildButton('2'),
                BuildButton('3'),
                BuildButton('+'),
              ]),
              Row(children: [
                BuildButton('.'),
                BuildButton('0'),
                BuildButton('( )'),
                BuildButton('='),
              ]),
            ])
          ],
        )));
  }
}
