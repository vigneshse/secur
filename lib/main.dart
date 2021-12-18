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
          primarySwatch: Colors.lightGreen, backgroundColor: Colors.yellow),
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

  void _generatePassword(String saltKey) {
    setState(() {
        _password = SecureGenerator.generateRandomSecure(true)+SecureGenerator.saltSecret(saltKey);
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Enter salt key'),
                controller: textController,
                showCursor: true,
                maxLength: 3,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                autofocus: true,
                style: Theme.of(context).textTheme.headline5,
              ),
              SelectableText.rich(
                TextSpan(
                  text: _password,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              CupertinoButton.filled(
                onPressed: () => _generatePassword(textController.text),
                child: const Text('Generate Secur'),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
