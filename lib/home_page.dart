import 'package:flutter/material.dart';
import 'package:otimizador_academico/recommended_classes_page.dart';
import 'package:otimizador_academico/select_classes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
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
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(children: [
                    selectedClasses.length > 0
                        ? Text(
                            selectedClasses.length == 1
                                ? '${selectedClasses.length} DISCIPLINA CURSADA'
                                : '${selectedClasses.length} DISCIPLINAS CURSADAS',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                letterSpacing: 1),
                          )
                        : Expanded(
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0, color: Color(0xFF3b3b3b)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            10.0) //                 <--- border radius here
                                        )),
                                child: Center(
                                  child: Text('NENHUMA DISCIPLINA CURSADA',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                        color: Color(0xFF3b3b3b),
                                      )),
                                )))
                  ]),
                  SizedBox(
                    height: selectedClasses.length > 0 ? 10 : 0,
                  ),
                  Center(
                      child: selectedClasses.length > 0
                          ? Expanded(
                              child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height -
                                              280,
                                      minHeight: 10),
                                  child: ListView.builder(
                                      itemCount: selectedClasses.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) => ListTile(
                                            title: Text(
                                                selectedClasses[index]['name']),
                                            // dense: true,
                                            contentPadding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            visualDensity:
                                                VisualDensity(vertical: -2.5),
                                          ))),
                              //   )
                              // ],
                            )
                          : null),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.fromLTRB(0, 20, 0, 20)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                                // padding: MaterialStateProperty.all(
                                //     EdgeInsets.fromLTRB(20, 20, 20, 20)),
                                overlayColor:
                                    // 0xFF8adeaf
                                    MaterialStateProperty.all(
                                        Color.fromARGB(255, 107, 185, 248))),
                            child: const Text(
                              'SELECIONAR DISCIPLINAS CURSADAS',
                              style: TextStyle(
                                  letterSpacing: 1, color: Colors.white),
                            ),
                            onPressed: () async {
                              var result = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SelectClassesPage(
                                  selectedClasses: selectedClasses,
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: selectedClasses.length > 0
                            ? TextButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.fromLTRB(0, 20, 0, 20)),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                    // padding: MaterialStateProperty.all(
                                    //     EdgeInsets.fromLTRB(20, 20, 20, 20)),
                                    overlayColor:
                                        // 0xFF8adeaf
                                        MaterialStateProperty.all(
                                            Color.fromARGB(
                                                255, 107, 185, 248))),
                                child: const Text(
                                  'BUSCAR DISCIPLINAS RECOMENDADAS',
                                  style: TextStyle(
                                      letterSpacing: 1, color: Colors.white),
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
                              )
                            : Text(''),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
