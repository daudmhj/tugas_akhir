import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tugas_akhir/result.dart';
import 'package:tugas_akhir/page_detail.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class PageResult extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageResultState();
}

class _PageResultState extends State<PageResult> {
  //Membuat list kosong sebagai tempat menaruh hasil API (GET)
  List<Result> list = List();
  //Sebagai penanda proses pengambilan API sudah selesai atau belum
  bool isLoading = false;

  //method untuk mengambil data result API (GET)
  getData() async {
    setState(() {
      isLoading = true;
    });
    final response =
    await http.get("http://192.168.43.197:5000/reads");
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new Result.fromJson(data))
          .toList();
      _scaffoldState.currentState.showSnackBar(SnackBar(
        content: Text("Load Data Success"),
      ));
      setState(() {
        isLoading = false;
      });
    } else {
      _scaffoldState.currentState.showSnackBar(SnackBar(
        content: Text("Load Data Failed"),
      ));
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  final waitLabel = new Text("Please Wait . . .",
      textAlign: TextAlign.center,
      style: new TextStyle(fontSize: 24.0)
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Text("Result"),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 135.0),
            child: Row (
                children: <Widget>[
                  RaisedButton(
                    child: new Text("Get Data"),
                    onPressed: getData
                  ),
                ]
            )
        ),
        body: isLoading
            ? Stack(
              children: <Widget>[
                Center(
                  child: waitLabel,
                ),
              ],
            )
            : ListView(
            children : <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  onSelectAll: (b) {},
                  sortAscending: true,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text('ID'),
                    ),
                    DataColumn(
                      label: Text('Name'),
                    ),
                    DataColumn(
                      label: Text('Date'),
                    ),
                    DataColumn(
                      label: Text('Mean'),
                    ),
                    DataColumn(
                      label: Text('Sdnn'),
                    ),
                    DataColumn(
                      label: Text('Sdsd'),
                    ),
                    DataColumn(
                      label: Text('Rmssd'),
                    ),
                    DataColumn(
                      label: Text('Pnn20'),
                    ),
                    DataColumn(
                      label: Text('Pnn50'),
                    ),
                    DataColumn(
                      label: Text('Lf'),
                    ),
                    DataColumn(
                      label: Text('Hf'),
                    ),
                    DataColumn(
                      label: Text('LfHf'),
                    ),
                    DataColumn(
                      label: Text('Classification'),
                    ),
                  ],
                  rows: list
                      .map(
                        (itemRow) => DataRow(
                      cells: [
                        DataCell(
                          Text(itemRow.id+ ' '),
                          showEditIcon: true,
                          placeholder: false,
                          onTap: () {
                            Navigator.push(
                            context,
                              MaterialPageRoute(
                                builder: (context) =>
                                  Content(id: itemRow.id, name: itemRow.name, date: itemRow.date,
                                      mean: itemRow.mean, sdnn: itemRow.sdnn, sdsd: itemRow.sdsd, rmssd: itemRow.rmssd,
                                      pnn20: itemRow.pnn20, pnn50: itemRow.pnn50, lf: itemRow.lf,
                                      hf: itemRow.hf, lfhf: itemRow.lfhf, file: itemRow.file,
                                      image: itemRow.image, classification: itemRow.classification,),
                              ),
                            );
                          },
                        ),
                        DataCell(
                          Text(itemRow.name),
                          showEditIcon: false,
                          placeholder: false,
                        ),
                        DataCell(
                          Text(itemRow.date.toString()),
                          showEditIcon: false,
                          placeholder: false,
                        ),
                        DataCell(
                          Text(itemRow.mean.toString()),
                          showEditIcon: false,
                          placeholder: false,
                        ),
                        DataCell(
                          Text(itemRow.sdnn.toString()),
                          showEditIcon: false,
                          placeholder: false,
                        ),
                        DataCell(
                          Text(itemRow.sdsd.toString()),
                          showEditIcon: false,
                          placeholder: false,
                        ),
                        DataCell(
                          Text(itemRow.rmssd.toString()),
                          showEditIcon: false,
                          placeholder: false,
                        ),
                        DataCell(
                          Text(itemRow.pnn20.toString()),
                          showEditIcon: false,
                          placeholder: false,
                        ),
                        DataCell(
                          Text(itemRow.pnn50.toString()),
                          showEditIcon: false,
                          placeholder: false,
                        ),
                        DataCell(
                          Text(itemRow.lf.toString()),
                          showEditIcon: false,
                          placeholder: false,
                        ),
                        DataCell(
                          Text(itemRow.hf.toString()),
                          showEditIcon: false,
                          placeholder: false,
                        ),
                        DataCell(
                          Text(itemRow.lfhf.toString()),
                          showEditIcon: false,
                          placeholder: false,
                        ),
                        DataCell(
                          Text(itemRow.classification),
                          showEditIcon: false,
                          placeholder: false,
                        ),
                      ],
                    ),
                  ).toList(),
                ),
              ),
            ]
        )
    );
  }
}