import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  final List<Map<String, dynamic>> _allClasses = [
    {"id": 1, "name": "Algoritmos e Estruturas de Dados", "isSelected": false},
    {"id": 2, "name": "Banco de Dados", "isSelected": false},
    {"id": 3, "name": "Projeto I", "isSelected": false},
    {"id": 4, "name": "Projeto II", "isSelected": false},
    {"id": 5, "name": "TCC", "isSelected": false},
    // {"id": 6, "name": "Colin", "isSelected": false},
    // {"id": 7, "name": "Audra", "isSelected": false},
    // {"id": 8, "name": "Banana", "isSelected": false},
    // {"id": 9, "name": "Caversky", "isSelected": false},
    // {"id": 10, "name": "Becky", "isSelected": false},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundClasses = [];

  @override
  initState() {
    // at the beginning, all users are shown
    _foundClasses = _allClasses;
    super.initState();
  }

  List<Map<String, dynamic>> selectedClasses = [];

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
        title: const Text('Disciplinas cursadas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // const SizedBox(
            //   height: 20,
            // ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Buscar disciplina',
                  suffixIcon: Icon(Icons.search)),
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
                        // subtitle: Text(
                        //     '${_foundClasses[index]["age"].toString()} years old'),
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
                            if (_foundClasses[index]['isSelected'] == true) {
                              selectedClasses.add(_foundClasses[index]);
                            } else if (_foundClasses[index]['isSelected'] ==
                                false) {
                              selectedClasses.removeWhere((element) =>
                                  element['name'] ==
                                  _foundClasses[index]['name']);
                            }
                            print(selectedClasses);
                          });
                        },
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
    );
  }
}
