import 'package:flutter/material.dart';
import 'package:flutter_javascript_channel/web_view_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        ElevatedButton(onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewScreen()));
        },child: Text("Go To Web Page"),),
      ),
    );
  }
}
