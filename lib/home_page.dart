import 'package:flutter/material.dart';
import 'package:otimizador_academico/recommended_classes_page.dart';
import 'package:otimizador_academico/select_classes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well

  List<Map<String, dynamic>> selectedClasses = [];

  String dropdownvalue = '5';

  // List of items in our dropdown menu
  var items = [
    '3',
    '4',
    '5',
  ];

  @override
  initState() {
    // at the beginning, all users are shown

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
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.0),
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
                                          border: Border.all(width: 1.0),
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
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      1))
                                                      : Text(
                                                          '${selectedClasses.length} DISCIPLINAS CURSADAS',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      1)))
                                                  : Center(
                                                      child: Text(
                                                          'NENHUMA DISCIPLINA CURSADA',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      1)),
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
                                            //there is await inside, so add async tag

                                            var result = await Navigator.push(
                                                context, MaterialPageRoute(
                                                    builder: (context) {
                                              return SelectClassesPage(
                                                selectedClasses:
                                                    selectedClasses,
                                              );
                                            })); //Navigate to another page
                                            // this will return data which is assigned on Navigator.pop(context, returndata);

                                            setState(() {
                                              print(result);
                                              selectedClasses =
                                                  result; //update the returndata with the return result,
                                              //update UI with setState()
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
                              border: Border.all(width: 1.0),
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
                                          border: Border.all(width: 1.0),
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
                                                    fontSize: 14),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Center(
                                              child: DropdownButton(
                                                // Initial Value
                                                value: dropdownvalue,

                                                // Down Arrow Icon
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),

                                                elevation: 16,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                                underline: Container(
                                                  height: 2,
                                                  color: Colors.black,
                                                ),

                                                // Array list of items
                                                items:
                                                    items.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(items),
                                                  );
                                                }).toList(),
                                                // After selecting the desired option,it will
                                                // change button value to selected value
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
