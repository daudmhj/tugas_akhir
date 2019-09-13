import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(
  title: "Analyze",
  home: new PageAnalyze(),
));

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class PageAnalyze extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _PageAnalyzeState();
}

class _PageAnalyzeState extends State<PageAnalyze> {

  bool _isLoading = false;
  bool _isFieldNameValid;
  TextEditingController _controllerName = TextEditingController();

  Future<bool> analyze(String name) async {
    var response = await http.get("http://192.168.43.197:5000/analyze/"+name);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  final lampLabel = new Text("Please Wait until the Lamp of Wemos Turn Off",
      textAlign: TextAlign.center,
      style: new TextStyle(fontSize: 24.0)
  );

  final nameLabel = new Text("Please Input the Name of Patient",
      textAlign: TextAlign.center,
      style: new TextStyle(fontSize: 18.0)
  );

  final analyzeLabel = new Text("Click ANALYZE to begin Calculate HRV",
      textAlign: TextAlign.center,
      style: new TextStyle(fontSize: 18.0)
  );

  final waitLabel = new Text("And Please Wait... \n Test Result will be Display at the Result Tab",
      textAlign: TextAlign.center,
      style: new TextStyle(fontSize: 24.0)
  );

  final processLabel = new Text("Please Wait... \n Calculate HRV in Process",
      textAlign: TextAlign.center,
      style: new TextStyle(fontSize: 24.0)
  );

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      key: _scaffoldState,
      appBar: new AppBar(title: new Text("Analyze")),
      body: _isLoading
      ? Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.3,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.grey,
            ),
          ),
          Center(
            child: processLabel,
          ),
        ],
      )
      : new Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            lampLabel,
            SizedBox(height: 30.0),
            nameLabel,
            SizedBox(height:10.0),
            _buildTextFieldNama(),
            SizedBox(height: 30.0),
            analyzeLabel,
            SizedBox(height: 10.0),
            ButtonTheme(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              minWidth: 100.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                onPressed: () {
                  if (_isFieldNameValid == null ||
                      !_isFieldNameValid) {
                    _scaffoldState.currentState.showSnackBar(
                      SnackBar(
                        content: Text("Please fill patient name"),
                      ),
                    );
                    return;
                  }
                  setState((){
                    _isLoading = true;
                  });
                  String name = _controllerName.text.toString();
                  analyze(name).then((isSuccess) {
                    setState(() => _isLoading = false);
                    if (isSuccess) {
                      _scaffoldState.currentState.showSnackBar(SnackBar(
                        content: Text("Analyze Success"),
                      ));
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        _isLoading = false;
                      });
                      _scaffoldState.currentState.showSnackBar(SnackBar(
                        content: Text("Analyze Failed"),
                      ));
                    }
                  });
                },
                padding: EdgeInsets.all(12),
                color: Colors.pink[300],
                child: Text('ANALAYZE', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 30.0),
            waitLabel
          ],
        ),
      )
    );
  }

  Widget _buildTextFieldNama() {
    return TextField(
      controller: _controllerName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Patient Name",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Name is Required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNameValid) {
          setState(() => _isFieldNameValid = isFieldValid);
        }
      },
    );
  }
}