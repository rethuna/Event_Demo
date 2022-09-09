import 'package:flutter/material.dart';

import '../config/palette.dart';
import 'Navigation_screen.dart';

class PostScreen extends StatefulWidget {
  final String data;

  const PostScreen(this.data);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        elevation: 0.0,
        actions: <Widget>[],
      ),
      drawer: MyDrawerDirectory(), // Navigation drawer

      body:Stack(
        children: <Widget>[dashBg, content],
      ),
    );

  }
  //Dashboard creation
  get dashBg => Column(
    children: <Widget>[
      Expanded(
        child: Container(color: Palette.primaryColor),
        flex: 1,
      ),
      Expanded(
        child: Container(color: Palette.secondaryColor),
        flex: 5,
      ),
    ],
  );

  get content => Container(
    child: Column(
      children: <Widget>[
        //  header,
        grid,
      ],
    ),
  );

  get grid => Expanded(
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white70,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(15),
      child: Container(
        child: Column(
          children: <Widget>[
            Text(widget.data,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: _createDataTable(),
            ),
          ],
        ),
      ),
    ),
  );

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(),
      rows: _createRows(),
      dividerThickness: 5,
      dataRowHeight: 80,
      showBottomBorder: true,
      headingTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),
      headingRowColor: MaterialStateProperty.resolveWith(
              (states) => Colors.black26
      ),
      dataRowColor: MaterialStateColor.resolveWith( (Set<MaterialState> states) => states.contains(MaterialState.selected)
          ? Colors.pink
          : Colors.black12
      ),
    );
  }
  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Date')),
      DataColumn(label: Text('Time')),
      DataColumn(label: Text('Event'))
    ];
  }
  List<DataRow> _createRows() {
    return [
      DataRow(cells: [
        DataCell(Text('10/09/2022',style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.bold),)),
        DataCell(Container(
    width: 40,child: Text('9:00',style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.bold))),),
        DataCell(Text('Wedding Event',style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.bold)))
      ]),
      DataRow(cells: [
        DataCell(Text('10/09/2022',style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.bold))),
        DataCell(Text('12:00',style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.bold))),
        DataCell(Text('Lunch',style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.bold)))
      ]),
      DataRow(cells: [
        DataCell(Text('10/09/2022',style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.bold))),
        DataCell(Text('17:00',style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.bold))),
        DataCell(Text('Reception Event',style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.bold)))
      ]),DataRow(cells: [
        DataCell(Text('10/09/2022',style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.bold))),
        DataCell(Text('20:00',style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.bold))),
        DataCell(Text('Party',style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.bold)))
      ])
    ];
  }

}

