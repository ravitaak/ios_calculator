import 'package:flutter/material.dart';

class MyCal extends StatefulWidget {
  const MyCal({super.key});
  @override
  State<MyCal> createState() => _MyCal();
}

class _MyCal extends State<MyCal> {
  double fontSizeForText = 100.0;
  Widget createBtn(textVal, btnColor, textColor) {
    return MaterialButton(
        highlightColor: Colors.white,
        padding: const EdgeInsets.all(20),
        shape: const CircleBorder(),
        color: btnColor,
        onPressed: () => btnProcess(textVal),
        child: Text(
          "$textVal",
          style: TextStyle(
            color: textColor,
            fontSize: 35,
            fontWeight: FontWeight.w500,
          ),
        ));
  }

  Widget createBtnZero(textVal, btnColor) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(34, 20, 128, 20),
          shape: const StadiumBorder(),
          color: btnColor,
          onPressed: () => btnProcess(textVal),
          child: Text(
            "$textVal",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  String res = "";
  double firstNumber = 0;
  double secondNumber = 0;
  String opratorToPerform = "";
  String textToDisplay = "0";
  void btnProcess(String textVal) {
    if (textVal == 'C') {
      textToDisplay = "";
      res = "0";
    } else if (textVal == '+' ||
        textVal == '-' ||
        textVal == 'x' ||
        textVal == '%' ||
        textVal == '÷') {
      firstNumber = double.parse(textToDisplay);
      res = "0";
      opratorToPerform = textVal;
      if (textVal == '÷') {
        opratorToPerform = '/';
      }
    } else if (textVal == '0') {
      if (textToDisplay != '0') {
        res = (textToDisplay + textVal).toString();
      }
    } else if (textVal == '±') {
      if (textToDisplay.startsWith("-")) {
        res = textToDisplay.replaceFirst("-", "");
      } else {
        res = "-$textToDisplay";
      }
    } else if (textVal == '=') {
      secondNumber = double.parse(textToDisplay);
      if (opratorToPerform == '+') {
        res = (firstNumber + secondNumber).toString();
      } else if (opratorToPerform == '-') {
        res = (firstNumber - secondNumber).toString();
      } else if (opratorToPerform == '*') {
        res = (firstNumber * secondNumber).toString();
      } else if (opratorToPerform == '/') {
        res = (firstNumber / secondNumber).toString();
      } else if (opratorToPerform == '%') {
        res = (firstNumber % secondNumber).toString();
      } else {
        res = "0";
      }
    } else {
      if (textToDisplay == '0' || textToDisplay == '0.0') {
        textToDisplay = "";
      }
      if (!(textToDisplay.length >= 9)) {
        res = (textToDisplay + textVal).toString();
      }
    }
    setState(() {
      if (res.length > 3) {
        fontSizeForText = 60;
      } else {
        fontSizeForText = 100;
      }
      if (res.length >= 9) {}
      if (res == '0') {
        textToDisplay = "";
      } else {
        textToDisplay = decimalChecker(res);
      }
    });
  }

  String decimalChecker(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25),
            child: Text(
              textToDisplay,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSizeForText,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              createBtn("C", Colors.grey[400], Colors.black),
              createBtn("±", Colors.grey[400], Colors.black),
              createBtn("%", Colors.grey, Colors.black),
              createBtn("÷", Colors.amber[700], Colors.white),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              createBtn("7", Colors.grey[850], Colors.white),
              createBtn("8", Colors.grey[850], Colors.white),
              createBtn("9", Colors.grey[850], Colors.white),
              createBtn("+", Colors.amber[700], Colors.white),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              createBtn("4", Colors.grey[850], Colors.white),
              createBtn("5", Colors.grey[850], Colors.white),
              createBtn("6", Colors.grey[850], Colors.white),
              createBtn("-", Colors.amber[700], Colors.white),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              createBtn("1", Colors.grey[850], Colors.white),
              createBtn("2", Colors.grey[850], Colors.white),
              createBtn("3", Colors.grey[850], Colors.white),
              createBtn("x", Colors.amber[700], Colors.white),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              createBtnZero("0", Colors.grey[850]),
              createBtn(".", Colors.grey[850], Colors.white),
              createBtn("=", Colors.amber[700], Colors.white),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
