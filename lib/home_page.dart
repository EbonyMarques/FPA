import 'package:flutter/material.dart';
import 'package:otimizador_academico/recommended_classes_page.dart';
import 'package:otimizador_academico/select_classes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> selectedClasses = [];
  String dropdownvalue = '5';
  var items = ['3', '4', '5'];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Otimizador Acadêmico'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
                child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0, color: Color(0xFF3b3b3b)),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      10.0) //                 <--- border radius here
                                  ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        // margin: const EdgeInsets.all(15.0),
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.0,
                                              color: Color(0xFF3b3b3b)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  10.0) //                 <--- border radius here
                                              ),
                                        ),
                                        child: Column(
                                          children: [
                                            Center(
                                              child: selectedClasses.length > 0
                                                  ? (selectedClasses.length == 1
                                                      ? Text(
                                                          '${selectedClasses.length} DISCIPLINA CURSADA',
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                              letterSpacing: 1,
                                                              color: Color(
                                                                  0xFF3b3b3b)))
                                                      : Text(
                                                          '${selectedClasses.length} DISCIPLINAS CURSADAS',
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                              letterSpacing: 1,
                                                              color: Color(
                                                                  0xFF3b3b3b))))
                                                  : Center(
                                                      child: Text(
                                                          'NENHUMA DISCIPLINA CURSADA',
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                              letterSpacing: 1,
                                                              color: Color(
                                                                  0xFF3b3b3b))),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                          style: ButtonStyle(
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.fromLTRB(
                                                          0, 20, 0, 20)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.blue),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              )),
                                              // padding: MaterialStateProperty.all(
                                              //     EdgeInsets.fromLTRB(20, 20, 20, 20)),
                                              overlayColor:
                                                  // 0xFF8adeaf
                                                  MaterialStateProperty.all(
                                                      Color.fromARGB(
                                                          255, 107, 185, 248))),
                                          child: const Text(
                                            'SELECIONAR DISCIPLINAS CURSADAS',
                                            style: TextStyle(
                                                letterSpacing: 1,
                                                color: Colors.white),
                                          ),
                                          onPressed: () async {
                                            var result = await Navigator.push(
                                                context, MaterialPageRoute(
                                                    builder: (context) {
                                              return SelectClassesPage(
                                                selectedClasses:
                                                    selectedClasses,
                                              );
                                            }));
                                            setState(() {
                                              print(result);
                                              selectedClasses = result;
                                            });
                                          }),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0, color: Color(0xFF3b3b3b)),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      10.0) //                 <--- border radius here
                                  ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        // margin: const EdgeInsets.all(15.0),
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.0,
                                              color: Color(0xFF3b3b3b)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  10.0) //                 <--- border radius here
                                              ),
                                        ),
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                'QTDE. MÁXIMA DE DISCIPLINAS A SEREM RECOMENDADAS',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Color(0xFF3b3b3b),
                                                    letterSpacing: 1),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Center(
                                              child: DropdownButton(
                                                value: dropdownvalue,
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                elevation: 16,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF3b3b3b)),
                                                underline: Container(
                                                  height: 2,
                                                  color: Color(0xFF3b3b3b),
                                                ),
                                                items:
                                                    items.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(items),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    dropdownvalue = newValue!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.fromLTRB(
                                                    0, 20, 0, 20)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blue),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )),
                                            // padding: MaterialStateProperty.all(
                                            //     EdgeInsets.fromLTRB(20, 20, 20, 20)),
                                            overlayColor:
                                                // 0xFF8adeaf
                                                MaterialStateProperty.all(
                                                    Color.fromARGB(
                                                        255, 107, 185, 248))),
                                        child: const Text(
                                          'RECOMENDAR DISCIPLINAS',
                                          style: TextStyle(
                                              letterSpacing: 1,
                                              color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RecommendedClassesPage(
                                                        selectedClasses:
                                                            selectedClasses)),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ],
              ),
            )),
          ),
        ));
  }
}
