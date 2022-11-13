import 'package:calculator/consts/colors.dart';
import 'package:calculator/consts/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var input = "";

  var output = "";
  var hideinput = false;
  var outputSize = Dimensions.height40;
  var outputColor = orangeColor;

  clickButton(value) {
    if (value == "AC") {
      input = "";
      output = "";
    } else if (value == "C") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userinput = input;
        userinput = input.replaceAll("×", "*");
        Parser p = Parser();
        Expression expression = p.parse(userinput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
      }
      input = output;
      hideinput = true;
      outputSize = Dimensions.height48;
    } else {
      input = input + value;
      hideinput = false;
      outputSize = Dimensions.height40;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("Screen height : " + MediaQuery.of(context).size.height.toString());
    print("Screen width : " + MediaQuery.of(context).size.width.toString());
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.all(Dimensions.height8),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(Dimensions.height12),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            hideinput ? "" : input,
                            style: TextStyle(
                              fontSize: Dimensions.height48,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          Text(
                            output,
                            style: TextStyle(
                              fontSize: outputSize,
                              color: outputColor,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        button(text: "", backgroundColor: Colors.transparent),
                        button(
                            text: "AC",
                            backgroundColor: operatorColor,
                            textColor: orangeColor),
                        button(
                            text: "C",
                            backgroundColor: operatorColor,
                            textColor: orangeColor),
                        button(text: "/", backgroundColor: operatorColor),
                      ],
                    ),
                    Row(
                      children: [
                        button(text: "7", backgroundColor: buttonColor),
                        button(text: "8", backgroundColor: buttonColor),
                        button(text: "9", backgroundColor: buttonColor),
                        button(text: "×", backgroundColor: operatorColor),
                      ],
                    ),
                    Row(
                      children: [
                        button(text: "4", backgroundColor: buttonColor),
                        button(text: "5", backgroundColor: buttonColor),
                        button(text: "6", backgroundColor: buttonColor),
                        button(text: "-", backgroundColor: operatorColor),
                      ],
                    ),
                    Row(
                      children: [
                        button(text: "1", backgroundColor: buttonColor),
                        button(text: "2", backgroundColor: buttonColor),
                        button(text: "3", backgroundColor: buttonColor),
                        button(text: "+", backgroundColor: operatorColor),
                      ],
                    ),
                    Row(
                      children: [
                        button(text: "%", backgroundColor: operatorColor),
                        button(text: "0", backgroundColor: buttonColor),
                        button(text: ".", backgroundColor: operatorColor),
                        button(text: "=", backgroundColor: orangeColor),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget button({text, backgroundColor = buttonColor, textColor = white}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(Dimensions.height8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.height12)),
              padding: EdgeInsets.all(Dimensions.height12),
              backgroundColor: backgroundColor),
          onPressed: () => clickButton(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: Dimensions.height27,
                color: textColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
