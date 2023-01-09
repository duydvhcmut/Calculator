import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setWindowMaxSize(const Size(800, 1000));
  setWindowMinSize(const Size(512, 900));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const CalculatorPage(title: 'Calculator'),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key, required this.title});
  final String title;

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  //Button Widget
  Widget calbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: () => calculation(btntxt),
        style: ElevatedButton.styleFrom(
          backgroundColor: btncolor,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(0),
          shape: const CircleBorder(),
          minimumSize: const Size(90, 90),
          elevation: 0
        ),
        child: Text(
          btntxt,
          style: TextStyle(fontSize: 35, color: txtcolor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(text,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 100,
                    ),
                  ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child:
                Wrap(
              spacing: 5,
              alignment: WrapAlignment.spaceEvenly,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                calbutton('AC', Colors.grey, Colors.black),
                calbutton('+/-',Colors.grey,Colors.black),
                calbutton('%',Colors.grey,Colors.black),
                calbutton('/',Colors.amber,Colors.white),
              ],
            ),
            ),
            const SizedBox(height: 10,),
            Align(
              alignment: Alignment.topLeft,
              child:
                Wrap(
              spacing: 5,
              alignment: WrapAlignment.spaceEvenly,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                calbutton('7',Colors.grey,Colors.white),
                calbutton('8',Colors.grey,Colors.white),
                calbutton('9',Colors.grey,Colors.white),
                calbutton('x',Colors.amber,Colors.white),
              ],
            ),
            ),
           
            const SizedBox(height: 10,),
            Align(
              alignment: Alignment.topLeft,
              child:
                Wrap(
              spacing: 5,
              alignment: WrapAlignment.spaceEvenly,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                calbutton('4',Colors.grey,Colors.white),
                calbutton('5',Colors.grey,Colors.white),
                calbutton('6',Colors.grey,Colors.white),
                calbutton('-',Colors.amber,Colors.white),
              ],
            ),
            ),

            const SizedBox(height: 10,),
            Align(
              alignment: Alignment.topLeft,
              child:
                Wrap(
              spacing: 5,
              alignment: WrapAlignment.spaceEvenly,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                calbutton('1',Colors.grey,Colors.white),
                calbutton('2',Colors.grey,Colors.white),
                calbutton('3',Colors.grey,Colors.white),
                calbutton('+',Colors.amber,Colors.white),
              ],
            ),
            ),

            const SizedBox(height: 10,),

            Align(
              alignment: Alignment.topLeft,
              child:
                Wrap(
              spacing: 5,
              alignment: WrapAlignment.spaceEvenly,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => calculation('0'),
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(34, 20, 114, 20),
                  shape: const StadiumBorder(),
                  minimumSize: const Size(90, 90),
                  elevation: 0
                ),
                child: const Text(
                  '0',
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
                ),
                calbutton('.',Colors.grey,Colors.white),
                calbutton('=',Colors.amber,Colors.white),
              ],
            ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  //Calculator logic
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
