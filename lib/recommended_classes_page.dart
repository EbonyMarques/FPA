import 'package:flutter/material.dart';

class RecommendedClassesPage extends StatefulWidget {
  RecommendedClassesPage(
      {Key? key, required this.selectedClasses, required this.darkMode})
      : super(key: key);

  List<dynamic> selectedClasses;
  final bool darkMode;

  @override
  _RecommendedClassesPageState createState() => _RecommendedClassesPageState();
}

class _RecommendedClassesPageState extends State<RecommendedClassesPage> {
  final List<Map<String, dynamic>> _allClasses = [
    {"id": 1, "name": "Disciplina A", "timeCourse": 1, "isSelected": false},
    {"id": 2, "name": "Disciplina B", "timeCourse": 1, "isSelected": false},
    {"id": 3, "name": "Disciplina C", "timeCourse": 1, "isSelected": false},
    {"id": 4, "name": "Disciplina D", "timeCourse": 1, "isSelected": false},
    {"id": 5, "name": "Disciplina E", "timeCourse": 1, "isSelected": false},
    {"id": 6, "name": "Disciplina F", "timeCourse": 2, "isSelected": false},
    {"id": 7, "name": "Disciplina G", "timeCourse": 2, "isSelected": false},
    {"id": 8, "name": "Disciplina H", "timeCourse": 2, "isSelected": false},
    {"id": 9, "name": "Disciplina I", "timeCourse": 2, "isSelected": false},
    {"id": 10, "name": "Disciplina J", "timeCourse": 2, "isSelected": false},
    {"id": 11, "name": "Disciplina K", "timeCourse": 3, "isSelected": false},
    {"id": 12, "name": "Disciplina L", "timeCourse": 3, "isSelected": false},
    {"id": 13, "name": "Disciplina M", "timeCourse": 3, "isSelected": false},
    {"id": 14, "name": "Disciplina N", "timeCourse": 3, "isSelected": false},
    {"id": 15, "name": "Disciplina O", "timeCourse": 3, "isSelected": false},
    {"id": 16, "name": "Disciplina P", "timeCourse": 4, "isSelected": false},
    {"id": 17, "name": "Disciplina Q", "timeCourse": 4, "isSelected": false},
    {"id": 18, "name": "Disciplina R", "timeCourse": 4, "isSelected": false},
    {"id": 19, "name": "Disciplina S", "timeCourse": 4, "isSelected": false},
    {"id": 20, "name": "Disciplina T", "timeCourse": 4, "isSelected": false},
  ];

  dynamic dropdownValue = '3';

  @override
  initState() {
    if (!widget.selectedClasses.isEmpty) {
      for (var i = 0; i < widget.selectedClasses.length; i++) {
        var currentElement = widget.selectedClasses[i]['id'];

        print(widget.selectedClasses[i]);
      }
    }

    super.initState();
    print(widget.selectedClasses);
  }

  @override
  Widget build(BuildContext context) {
    // if (_allClasses.length >= 5) {
    //   setState(() {
    //     dropdownValue = '5';
    //   });
    // } else if (_allClasses.length == 4) {
    //   setState(() {
    //     dropdownValue = '4';
    //   });
    // } else if (_allClasses.length == 3) {
    //   setState(() {
    //     dropdownValue = '3';
    //   });
    // }
    for (var i = 0; i < widget.selectedClasses.length; i++) {
      Map currentElement = widget.selectedClasses[i];
      print(_allClasses);
      _allClasses
          .removeWhere((element) => element["id"] == currentElement['id']);
      // print(widget.selectedClasses[i]);
      print(currentElement);

      // _allClasses.remove(currentElement);
      print(_allClasses);
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Disciplinas recomendadas'),
          // leading: BackButton(onPressed: () => Navigator.pop(context)
          //     // Navigator.pop(context, widget.selectedClasses),
          //     ),
        ),
        body: WillPopScope(
          //WillPopScope will replace the default
          //"Mobile Back Button" and "Appbar Back button" action
          onWillPop: () {
            //on Back button press, you can use WillPopScope for another purpose also.
            Navigator.pop(context, _allClasses); //return data along with pop
            return new Future(
                () => false); //onWillPop is Future<bool> so return false
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // Container(
                //   margin: const EdgeInsets.all(0.0),
                //   padding: const EdgeInsets.all(10.0),
                //   decoration: BoxDecoration(
                //     border: Border.all(width: 1.0),
                //     borderRadius: BorderRadius.all(Radius.circular(
                //             5.0) //                 <--- border radius here
                //         ),
                //   ), //             <--- BoxDecoration here
                //   child: Column(
                //     children: [
                //       Text(
                //         'QTDE. DE DISCIPLINAS RECOMENDADAS',
                //         textAlign: TextAlign.right,
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 14,
                //             letterSpacing: 1),
                //       ),
                //       _allClasses.length > 2
                //           ? DropdownButton<String>(
                //               value: dropdownValue,
                //               icon: const Icon(Icons.arrow_downward),
                //               elevation: 16,
                //               style: widget.darkMode
                //                   ? const TextStyle(color: Colors.white)
                //                   : const TextStyle(color: Colors.black),
                //               underline: widget.darkMode
                //                   ? Container(
                //                       height: 2,
                //                       color: Colors.white,
                //                     )
                //                   : Container(
                //                       height: 2,
                //                       color: Colors.black,
                //                     ),
                //               onChanged: (String? newValue) {
                //                 setState(() {
                //                   dropdownValue = newValue!;
                //                 });
                //               },
                //               items: _allClasses.length >= 5
                //                   ? <String>['3', '4', '5']
                //                       .map<DropdownMenuItem<String>>(
                //                           (String value) {
                //                       return DropdownMenuItem<String>(
                //                         value: value,
                //                         child: Text(value),
                //                       );
                //                     }).toList()
                //                   : _allClasses.length == 4
                //                       ? <String>['3', '4']
                //                           .map<DropdownMenuItem<String>>(
                //                               (String value) {
                //                           return DropdownMenuItem<String>(
                //                             value: value,
                //                             child: Text(value),
                //                           );
                //                         }).toList()
                //                       : _allClasses.length == 3
                //                           ? <String>['3']
                //                               .map<DropdownMenuItem<String>>(
                //                                   (String value) {
                //                               return DropdownMenuItem<String>(
                //                                 value: value,
                //                                 child: Text(value),
                //                               );
                //                             }).toList()
                //                           : _allClasses.length == 2
                //                               ? <String>[
                //                                   '2'
                //                                 ].map<DropdownMenuItem<String>>(
                //                                   (String value) {
                //                                   return DropdownMenuItem<
                //                                       String>(
                //                                     value: value,
                //                                     child: Text(value),
                //                                   );
                //                                 }).toList()
                //                               : <String>[
                //                                   '1'
                //                                 ].map<DropdownMenuItem<String>>(
                //                                   (String value) {
                //                                   return DropdownMenuItem<
                //                                       String>(
                //                                     value: value,
                //                                     child: Text(value),
                //                                   );
                //                                 }).toList(),
                //             )
                //           : SizedBox(),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'DISCIPLINAS A CURSAR NO SEMESTRE: ',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 1),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    _allClasses.length > 2
                        ? DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: widget.darkMode
                                ? const TextStyle(color: Colors.white)
                                : const TextStyle(color: Colors.black),
                            underline: widget.darkMode
                                ? Container(
                                    height: 2,
                                    color: Colors.white,
                                  )
                                : Container(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                            onChanged: (String? newValue) {
                              print('oxe?');
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: _allClasses.length >= 5
                                ? <String>['3', '4', '5']
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()
                                : _allClasses.length == 4
                                    ? <String>['3', '4']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()
                                    : _allClasses.length == 3
                                        ? <String>['3']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList()
                                        : _allClasses.length == 2
                                            ? <String>['2']
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList()
                                            : <String>['1']
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                          )
                        : SizedBox(),
                  ],
                ),
                Expanded(
                  child: widget.selectedClasses.isNotEmpty
                      ?
                      // ListView.builder(
                      //     itemCount: widget.selectedClasses.length,
                      //     itemBuilder: (context, index) => ListTile(
                      //           // leading: Text(
                      //           //   _foundClasses[index]["id"].toString(),
                      //           //   style: const TextStyle(fontSize: 24),
                      //           // ),
                      //           title:
                      //               Text(widget.selectedClasses[index]['name']),
                      //           // subtitle: Text(
                      //           //     '${_foundClasses[index]["age"].toString()} years old'),
                      //           trailing: widget.selectedClasses[index]
                      //                   ['isSelected']
                      //               ? Icon(
                      //                   Icons.check_circle,
                      //                   color: Colors.green[700],
                      //                 )
                      //               : Icon(
                      //                   Icons.check_circle_outline,
                      //                   color: Colors.grey,
                      //                 ),
                      //         ))

                      ListView.builder(
                          // itemCount: _allClasses.length,
                          itemCount: _allClasses.length > 3
                              ? int.parse(dropdownValue)
                              : _allClasses.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ListTile(
                                title: Text(_allClasses[index]['name']),
                                subtitle: Text(
                                    '${_allClasses[index]['timeCourse']}º período'),
                                // dense: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                visualDensity: VisualDensity(vertical: -2.5),
                              ))
                      : const Text(
                          '...',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}
