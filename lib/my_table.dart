import 'package:flutter/material.dart';

class MyTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
        child: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  heading("Id"),
                  heading("Name"),
                  heading("Profession"),
                  heading("Student"),
                  heading("Id"),
                  heading("Name"),
                  heading("Profession"),
                  heading("Status"),
                  heading("Action"),
                ],
                rows: [
                  data("john", "Approved", isInProgress: false, isHide: true),
                  data("john", "In progress", isInProgress: true, isHide: true),
                  data("john", "Submitted", isInProgress: true, isHide: true),
                  data("john", "In progress", isInProgress: true, isHide: true),
                  data("john", "Submitted", isHide: true),
                  data("john", "Approved", isInProgress: false),
                  data("john", "In progress", isInProgress: true),
                  data("john", "In progress", isInProgress: true),
                  data("john", "In progress", isInProgress: true),
                  data(
                    "john",
                    "Approved",
                    isInProgress: false,
                  ),
                  data("john", "In progress", isInProgress: true),
                  data(
                    "john",
                    "In progress",
                    isInProgress: true,
                  ),
                  data(
                    "john",
                    "Approved",
                    isInProgress: false,
                  ),
                  data(
                    "john",
                    "In progress",
                    isInProgress: true,
                  ),
                  data(
                    "john",
                    "In progress",
                    isInProgress: true,
                  ),
                  data(
                    "john",
                    "In progress",
                    isInProgress: true,
                  ),
                  data(
                    "john",
                    "Approved",
                    isInProgress: false,
                  ),
                  data("john", "In progress", isInProgress: true),
                  data("john", "In progress", isInProgress: true),
                  data("john", "In progress", isInProgress: true),
                  data("john", "In progress", isInProgress: true),
                ],
                showCheckboxColumn: false,
                // <-- this is important
                headingRowColor:
                    MaterialStateColor.resolveWith((states) => Colors.blue),
                // decoration: BoxDecoration(
                //     border: Border.all(width: 3.0, color: Colors.grey)),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

heading(String title) {
  return DataColumn(
      label: Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
}

data(String title, String status, {bool? isHide, bool? isInProgress}) {
  return DataRow(
      onSelectChanged: (b) {
        print('row clicked');
      },
      cells: [
        DataCell(Text('5')),
        DataCell(Text(title)),
        DataCell(Text('Actor')),
        DataCell(Text('Student')),
        DataCell(Text('5')),
        DataCell(Text(title)),
        DataCell(Text('Actor')),
        DataCell(Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(6),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isInProgress == null
                  ? Colors.yellow
                  : isInProgress == true
                      ? Colors.blue
                      : Colors.green,
              borderRadius: BorderRadius.circular(10.0)),
          child: Text(status),
        )),
        DataCell(Row(
          children: [
            IconButton(
              onPressed: () {
                print('edit');
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                print('copy');
              },
              icon: Icon(Icons.copy),
            ),
            isHide == null
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      print('refresh');
                    },
                    icon: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        child: Icon(Icons.refresh, color: Colors.white)),
                  ),
          ],
        )),
      ]);
}
