import 'package:flutter/material.dart';
import 'package:oscilloscope/oscilloscope.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class PageOscilloscope extends StatefulWidget {
  @override
  _OscilloscopeState createState() => _OscilloscopeState();
}

class _OscilloscopeState extends State<PageOscilloscope> {

  // Membuat list untuk menyimpan data ECG
  List<double> dataECG = List();
  Timer _timer;

  Future<int> getData() async {
    // Meminta Data Signal ECG dalam bentuk satuan kepada ESP8266
    final String url = 'http://192.168.43.241/get';
    var res = await http.get(Uri.encodeFull(url), headers: { 'accept':'application/json' });
    print(double.parse(res.body));
    setState(() {
      // Menambahkan satuan sinyal ECG ke dalam list
      dataECG.add(double.parse(res.body));
    });
    return 200;
  }

  /// method untuk mengambil data satuan ecg secara terus menerus
  _generateTrace(Timer t){
    // Fungsi mengambil data satuan ECG
    getData();
  }

  @override
  initState() {
    super.initState();
    // menjalankan method untuk mengambil data terus menerus per 60ms
    _timer = Timer.periodic(Duration(milliseconds: 60), _generateTrace);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Widget Oscilloscope untuk menampilkan data ECG
    Oscilloscope scopeECG = Oscilloscope(
      showYAxis: true,
      padding: 20.0,
      backgroundColor: Colors.black,
      traceColor: Colors.yellow,
      yAxisMax: 1000.0,
      yAxisMin: -1.0,
      dataSet: dataECG,
    );

    // Tampilan
    return Scaffold(
      appBar: AppBar(
        title: Text("Oscilloscope"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: scopeECG,
          ),
        ],
      ),
    );
  }
}