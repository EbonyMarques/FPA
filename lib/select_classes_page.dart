import 'package:flutter/material.dart';

class SelectClassesPage extends StatefulWidget {
  SelectClassesPage({Key? key, required this.selectedClasses})
      : super(key: key);
  List<dynamic> selectedClasses;

  @override
  _SelectClassesPageState createState() => _SelectClassesPageState();
}

class _SelectClassesPageState extends State<SelectClassesPage> {
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

  List<Map<String, dynamic>> _foundClasses = [];

  @override
  initState() {
    if (!widget.selectedClasses.isEmpty) {
      for (var i = 0; i < widget.selectedClasses.length; i++) {
        var currentElement = widget.selectedClasses[i]['id'];
        if (widget.selectedClasses[i]['isSelected'] == true) {
          _allClasses[currentElement - 1]['isSelected'] = true;
        }
      }
    }

    _foundClasses = _allClasses;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allClasses;
    } else {
      results = _allClasses
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

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
          onWillPop: () {
            Navigator.pop(
                context, widget.selectedClasses);
            return new Future(
                () => false);
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              children: [
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
                            title: Text(_foundClasses[index]['name']),
                            subtitle: Text(
                                '${_foundClasses[index]['timeCourse']}º período'),
                            trailing: _foundClasses[index]['isSelected'] == true
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
                              });
                            },
                            visualDensity: VisualDensity(vertical: -2.5),
                          ),
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
