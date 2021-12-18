import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:secur/secure_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Secur',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: Colors.blueGrey,
          backgroundColor: Colors.yellow,
          scaffoldBackgroundColor: Colors.black12),
      home: const MyHomePage(title: 'Password with Salt'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _password = "";
  final textController = TextEditingController();
  FocusNode focusNode = FocusNode();

  void _generatePassword(String saltKey) {
    setState(() {
      _password = SecureGenerator.generateRandomSecure(true) +
          SecureGenerator.saltSecret(saltKey);
    });
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        elevation: 50.0,
        leading: const Icon(Icons.account_circle_rounded),
        shadowColor: Colors.teal,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Salt Key",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.teal,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: TextField(
                  decoration:
                      const InputDecoration(contentPadding: EdgeInsets.zero),
                  controller: textController,
                  showCursor: true,
                  maxLength: 3,
                  focusNode: focusNode,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: SelectableText.rich(
                  TextSpan(
                    text: _password,
                    style: const TextStyle(color: Colors.teal, fontSize: 20),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(50.0),
                  child: CupertinoButton.filled(
                    onPressed: () => _generatePassword(textController.text),
                    child: const Text('Generate Secur'),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
