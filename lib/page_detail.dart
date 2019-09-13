import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  final String id;
  final String name;
  final String date;
  final double mean;
  final double sdnn;
  final double sdsd;
  final double rmssd;
  final double pnn20;
  final double pnn50;
  final double lf;
  final double hf;
  final double lfhf;
  final String file;
  final String image;
  final String classification;

  Content({Key key, this.id, this.name, this.date, this.mean, this.sdnn, this.sdsd, this.rmssd,
    this.pnn20, this.pnn50, this.lf, this.hf, this.lfhf, this.file, this.image, this.classification}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _id = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('ID : '+
        id,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 28.0, color: Colors.black),
      ),
    );

    final _name = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('Nama : '+
        name,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );

    final _date = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('Tanggal Tes : '+
          date,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );

    final _mean = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('MEAN : '+
          mean.toString(),
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );

    final _sdnn = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('SDNN : '+
          sdnn.toString(),
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );

    final _sdsd = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('SDSD : '+
          sdnn.toString(),
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );

    final _rmssd = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('RMSSD : '+
          rmssd.toString(),
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );

    final _pnn20 = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('PNN20 : '+
          pnn20.toString(),
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );

    final _pnn50 = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('PNN50 : '+
          pnn50.toString(),
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );

    final _lf = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('LF : '+
          lf.toString(),
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );

    final _hf = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('HF : '+
          hf.toString(),
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );

    final _lfhf = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('LF/HF : '+
          lfhf.toString(),
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );

    final _classification = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('Classification : '+
          classification,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );

    final _image = SizedBox(
        height: 400.0,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.network(
                'http://192.168.43.197:5000/static/plots/'+image,
                fit: BoxFit.cover,
              ),
            ),
          ],
        )
    );

    final body = ListView(
      // width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      children: <Widget>[_id, _name, _date, _mean, _sdnn, _sdsd, _rmssd, _pnn20,
        _pnn50, _lf, _hf, _lfhf, _classification, _image],
//      decoration: BoxDecoration(
//        gradient: LinearGradient(colors: [
//          Colors.blue,
//          Colors.lightBlueAccent,
//        ]),
//      ),
//      child: Column(
//        children: <Widget>[pranikah, welcome, lorem],
//      ),
    );

    return Scaffold(
      appBar: new AppBar(
          iconTheme: new IconThemeData(color: Colors.black)),
          backgroundColor: Colors.white,
      body: body,
    );
  }
}
