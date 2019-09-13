import 'package:flutter/material.dart';
import 'package:tugas_akhir/page_analyze.dart';
import 'package:http/http.dart' as http;
import 'package:countdown/countdown.dart';

class PageTest extends StatefulWidget {
  @override
  _PageTestState createState() => _PageTestState();
}

class _PageTestState extends State<PageTest> {

  var sub;
  CountDown cd;
  String countDownText = "00:05:00";
  var isLoading = false;

  void getECG() async {
    final response = await http.get("http://192.168.43.241/on");
  }

  void countdown(){
    cd = new CountDown(new Duration(minutes: 5));
    sub = cd.stream.listen(null);

    // start your countdown by registering a listener
    sub.onData((Duration d) {
      print(d);

      setState((){
        this.countDownText = d.toString();
      });
    });

    // when it finish the onDone cb is called
    sub.onDone(() {
      print("Press STOP");

      setState((){
        this.countDownText = "Press STOP";
      });
    });
  }

  @override
  void dispose() {
    sub.pause();
    super.dispose();
  }

  static stopECG() async {
    final response = await http.get("http://192.168.43.241/off");
  }

  @override
  Widget build(BuildContext context) {

    final startButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          getECG();
          countdown();
          setState((){
            isLoading = true;
          });
        },
        padding: EdgeInsets.all(12),
        color: Colors.pink[300],
        child: Text('START', style: TextStyle(color: Colors.white)),
      ),
    );

    final stopButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          stopECG();
          setState((){
            isLoading = false;
            sub.pause();
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PageAnalyze()),
          );
        },
        padding: EdgeInsets.all(12),
        color: Colors.pink[300],
        child: Text('STOP', style: TextStyle(color: Colors.white)),
      ),
    );

    final startLabel = FlatButton(
      child: Text(
        'Click START to Begin the Test',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    // Generate the Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: isLoading
      ? Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            new Text(countDownText,
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 24.0)
            ),
            stopButton,
          ],
        ),
      )
      : Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            startLabel,
            startButton,
          ],
        ),
      ),
    );
  }
}