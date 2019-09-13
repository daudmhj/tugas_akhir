/// Demo of using the oscilloscope package
///
/// In this demo 2 displays are generated showing the outputs for Sine & Cosine
/// The scope displays will show the data sets  which will fill the yAxis and then the screen display will 'scroll'
import 'package:flutter/material.dart';
import 'package:tugas_akhir/page_result.dart';
import 'package:tugas_akhir/page_oscilloscope.dart';
import 'package:tugas_akhir/page_test.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Tugas Akhir",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {

    final _kTabPages = <Widget>[
      Center(child: new PageOscilloscope()),
      Center(child: new PageTest()),
      Center(child: new PageResult()),
    ];

    final _kBottomNavbarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.library_books), title: Text('Oscilloscope')),
      BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('ECG')),
      BottomNavigationBarItem(icon: Icon(Icons.video_library), title: Text('Result')),
    ];

    assert(_kTabPages.length == _kBottomNavbarItems.length);

    final bottomNavbar = BottomNavigationBar(
      items: _kBottomNavbarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index){
        setState(() {
          _currentTabIndex = index;
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Tugas Akhir'),
      ),
      body: _kTabPages[_currentTabIndex],
      bottomNavigationBar: bottomNavbar,
    );
  }
}