import 'package:flutter/material.dart';

class SelectClassesPage extends StatefulWidget {
  // const SelectClassesPage({Key? key}) : super(key: key);
  SelectClassesPage({Key? key, required this.selectedClasses})
      : super(key: key);

  List<Map<String, dynamic>> selectedClasses;

  @override
  _SelectClassesPageState createState() => _SelectClassesPageState();
}

class _SelectClassesPageState extends State<SelectClassesPage> {
  // late List<Map<String, dynamic>> selectedClasses;

  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  final List<Map<String, dynamic>> _allClasses = [
    {
      "id": 1,
      "name": "Disciplina A",
      "timeCourse": "1º período",
      "isSelected": false
    },
    {
      "id": 2,
      "name": "Disciplina B",
      "timeCourse": "1º período",
      "isSelected": false
    },
    {
      "id": 3,
      "name": "Disciplina C",
      "timeCourse": "1º período",
      "isSelected": false
    },
    {
      "id": 4,
      "name": "Disciplina D",
      "timeCourse": "1º período",
      "isSelected": false
    },
    {
      "id": 5,
      "name": "Disciplina E",
      "timeCourse": "1º período",
      "isSelected": false
    },
    {
      "id": 6,
      "name": "Disciplina F",
      "timeCourse": "2º período",
      "isSelected": false
    },
    {
      "id": 7,
      "name": "Disciplina G",
      "timeCourse": "2º período",
      "isSelected": false
    },
    {
      "id": 8,
      "name": "Disciplina H",
      "timeCourse": "2º período",
      "isSelected": false
    },
    {
      "id": 9,
      "name": "Disciplina I",
      "timeCourse": "2º período",
      "isSelected": false
    },
    {
      "id": 10,
      "name": "Disciplina J",
      "timeCourse": "2º período",
      "isSelected": false
    },
    {
      "id": 11,
      "name": "Disciplina K",
      "timeCourse": "3º período",
      "isSelected": false
    },
    {
      "id": 12,
      "name": "Disciplina L",
      "timeCourse": "3º período",
      "isSelected": false
    },
    {
      "id": 13,
      "name": "Disciplina M",
      "timeCourse": "3º período",
      "isSelected": false
    },
    {
      "id": 14,
      "name": "Disciplina N",
      "timeCourse": "3º período",
      "isSelected": false
    },
    {
      "id": 15,
      "name": "Disciplina O",
      "timeCourse": "3º período",
      "isSelected": false
    },
    {
      "id": 16,
      "name": "Disciplina P",
      "timeCourse": "4º período",
      "isSelected": false
    },
    {
      "id": 17,
      "name": "Disciplina Q",
      "timeCourse": "4º período",
      "isSelected": false
    },
    {
      "id": 18,
      "name": "Disciplina R",
      "timeCourse": "4º período",
      "isSelected": false
    },
    {
      "id": 19,
      "name": "Disciplina S",
      "timeCourse": "4º período",
      "isSelected": false
    },
    {
      "id": 20,
      "name": "Disciplina T",
      "timeCourse": "4º período",
      "isSelected": false
    },
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundClasses = [];

  @override
  initState() {
    if (!widget.selectedClasses.isEmpty) {
      for (var i = 0; i < widget.selectedClasses.length; i++) {
        var currentElement = widget.selectedClasses[i]['id'];

        print(widget.selectedClasses[i]);

        _allClasses[currentElement - 1]['isSelected'] = true;

        print(_allClasses[currentElement - 1]);
      }
    }

    _foundClasses = _allClasses;
    super.initState();
    print(widget.selectedClasses);
  }
  // at the beginning, all users are shown

  // List<Map<String, dynamic>> selectedClasses = [];

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allClasses;
    } else {
      results = _allClasses
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundClasses = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Selecionar disciplinas'),
          leading: BackButton(
            onPressed: () => Navigator.pop(context, widget.selectedClasses),
          ),
        ),
        body: WillPopScope(
          //WillPopScope will replace the default
          //"Mobile Back Button" and "Appbar Back button" action
          onWillPop: () {
            //on Back button press, you can use WillPopScope for another purpose also.
            Navigator.pop(
                context, widget.selectedClasses); //return data along with pop
            return new Future(
                () => false); //onWillPop is Future<bool> so return false
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              children: [
                // const SizedBox(
                //   height: 20,
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    decoration: const InputDecoration(
                        labelText: 'Buscar disciplina',
                        suffixIcon: Icon(Icons.search)),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: _foundClasses.isNotEmpty
                      ? ListView.builder(
                          itemCount: _foundClasses.length,
                          itemBuilder: (context, index) => ListTile(
                            // leading: Text(
                            //   _foundClasses[index]["id"].toString(),
                            //   style: const TextStyle(fontSize: 24),
                            // ),
                            title: Text(_foundClasses[index]['name']),
                            // ${selectedClasses.length}
                            // subtitle: Text('${_foundClasses[index]["age"].toString()} years old'),
                            subtitle:
                                Text('${_foundClasses[index]['timeCourse']}'),
                            trailing: _foundClasses[index]['isSelected']
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.green[700],
                                  )
                                : Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.grey,
                                  ),
                            onTap: () {
                              setState(() {
                                _foundClasses[index]['isSelected'] =
                                    !_foundClasses[index]['isSelected'];
                                if (_foundClasses[index]['isSelected'] ==
                                    true) {
                                  widget.selectedClasses
                                      .add(_foundClasses[index]);
                                } else if (_foundClasses[index]['isSelected'] ==
                                    false) {
                                  widget.selectedClasses.removeWhere(
                                      (element) =>
                                          element['name'] ==
                                          _foundClasses[index]['name']);
                                }
                                print(widget.selectedClasses);
                              });
                            },
                            visualDensity: VisualDensity(vertical: -2.5),
                          ),

                          // itemBuilder: (context, index) => Card(
                          //   key: ValueKey(_foundClasses[index]["id"]),
                          //   // color: Colors.amberAccent,
                          //   // elevation: 4,
                          //   // margin: const EdgeInsets.symmetric(vertical: 10),
                          //   child: ListTile(
                          //     // leading: Text(
                          //     //   _foundClasses[index]["id"].toString(),
                          //     //   style: const TextStyle(fontSize: 24),
                          //     // ),
                          //     title: Text(_foundClasses[index]['name']),
                          //     // subtitle: Text(
                          //     //     '${_foundClasses[index]["age"].toString()} years old'),
                          //     trailing: _foundClasses[index]['isSelected']
                          //         ? Icon(
                          //             Icons.check_circle,
                          //             color: Colors.green[700],
                          //           )
                          //         : Icon(
                          //             Icons.check_circle_outline,
                          //             color: Colors.grey,
                          //           ),
                          //     onTap: () {
                          //       setState(() {
                          //         _foundClasses[index]['isSelected'] =
                          //             !_foundClasses[index]['isSelected'];
                          //         if (_foundClasses[index]['isSelected'] == true) {
                          //           selectedClasses.add(_foundClasses[index]);
                          //         } else if (_foundClasses[index]['isSelected'] ==
                          //             false) {
                          //           selectedClasses.removeWhere((element) =>
                          //               element['name'] ==
                          //               _foundClasses[index]['name']);
                          //         }
                          //         print(selectedClasses);
                          //       });
                          //       // print('ha');
                          //       // setState(() {
                          //       //   classes[index].isSelected =
                          //       //       !classes[index].isSelected;
                          //       //   if (classes[index].isSelected == true) {
                          //       //     selectedClasses.add(ClassModel(name, true));
                          //       //   } else if (classes[index].isSelected == false) {
                          //       //     selectedClasses.removeWhere((element) =>
                          //       //         element.name == classes[index].name);
                          //       //   }
                          //       //   print(selectedClasses);
                          //       // });
                          //     },
                          //   ),
                          // ),
                        )
                      : const Text(
                          'Sem resultados.',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}
