import 'package:flutter/material.dart';
import 'package:otimizador_academico/login_page.dart';
import 'package:otimizador_academico/recommended_classes_page.dart';
import 'package:otimizador_academico/select_classes_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';
import 'database.dart';

class HomePage extends StatefulWidget {
  final void Function(bool) setDarkMode;
  final bool darkMode;
  final dynamic uid;
  const HomePage(
      {Key? key,
      required this.setDarkMode,
      required this.darkMode,
      required this.uid})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  // List<Map<String, dynamic>> selectedClasses = [];
  dynamic selectedClasses = [];
  String dropdownvalue = '5';
  var items = ['3', '4', '5'];
  bool change = false;
  late bool darkMode;
  dynamic data = 0;

  @override
  initState() {
    super.initState();
    darkMode = widget.darkMode;
    // if ( == {}) {
    //   setData(widget.uid);
    // }
    // verify().then((value) => getDataLocal());
    getDataLocal();
  }

  // Future<void> verify() async {
  //   Map<String, dynamic> data1 = await getData(widget.uid);
  //   print('verify');
  //   print(data1);
  //   if (data1.length == 0) {
  //     print('feito!');
  //     setData(widget.uid);
  //   }
  // }

  void getDataLocal() async {
    Map<String, dynamic> data1 = await getData(widget.uid);
    print('opaaa');
    print(data1);

    // if (data1.length == 0) {
    //   print('feito!');
    //   setData(widget.uid);
    //   data1 = {
    //     'Disciplina A': {
    //       'id': 1,
    //       'name': 'Disciplina A',
    //       'timeCourse': '1º período',
    //       'isSelected': true
    //     },
    //     'Disciplina B': {
    //       'id': 2,
    //       'name': 'Disciplina B',
    //       'timeCourse': '1º período',
    //       'isSelected': true
    //     },
    //     'Disciplina C': {
    //       'id': 3,
    //       'name': 'Disciplina C',
    //       'timeCourse': '1º período',
    //       'isSelected': false
    //     },
    //     'Disciplina D': {
    //       'id': 4,
    //       'name': 'Disciplina D',
    //       'timeCourse': '1º período',
    //       'isSelected': false
    //     },
    //     'Disciplina E': {
    //       'id': 5,
    //       'name': 'Disciplina E',
    //       'timeCourse': '1º período',
    //       'isSelected': false
    //     }
    //   };
    // }

    dynamic data2 = [];
    dynamic data3 = [];
    setState(() {
      data1.forEach((k, v) => data2.add(v));
      data = data2;
      data2.forEach((d) => {
            if (d['isSelected']) {data3.add(d)}
          });
      selectedClasses = data3;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    print('verificando');
    print(widget.darkMode);
    print(widget.uid);

    // getData(widget.uid);
    print(data);

    print(selectedClasses);

    // selectedClasses.sort((a, b) => (b['name']).compareTo(a['name']));

    /// sort List<Map<String,dynamic>>

    return Scaffold(
      appBar: AppBar(
        title: const Text('Otimizador Acadêmico'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              authService.cleanToken();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginPage(
                      setDarkMode: widget.setDarkMode, darkMode: darkMode)));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.light_mode,
              color: Colors.white,
            ),
            onPressed: () async {
              print('to aqui');
              String? theme = await authService.getTheme();
              print('vamos ver');
              print(theme);
              if (theme == 'light') {
                print('troquei 1');
                authService.setThemeMode('dark');
                widget.setDarkMode(true);
                setState(() {
                  darkMode = true;
                });
              } else if (theme == 'dark') {
                print('troquei 2');
                authService.setThemeMode('light');
                widget.setDarkMode(false);
                setState(() {
                  darkMode = false;
                });
              }

              setState(() {
                change = true;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: selectedClasses.length > 0
                ?
                // SingleChildScrollView(
                //     child:
                Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(children: [
                        // selectedClasses.length > 0
                        //     ?
                        Text(
                          selectedClasses.length == 1
                              ? '${selectedClasses.length} DISCIPLINA CURSADA'
                              : '${selectedClasses.length} DISCIPLINAS CURSADAS',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 1),
                        )
                        // : Expanded(
                        //     child: Container(
                        //         padding: EdgeInsets.all(10),
                        //         decoration: BoxDecoration(
                        //             border: Border.all(
                        //                 width: 1.0,
                        //                 color: Color(0xFF3b3b3b)),
                        //             borderRadius: BorderRadius.all(
                        //                 Radius.circular(
                        //                     10.0) //                 <--- border radius here
                        //                 )),
                        //         child: Center(
                        //           child:
                        //               Text('NENHUMA DISCIPLINA CURSADA',
                        //                   style: TextStyle(
                        //                     fontWeight: FontWeight.bold,
                        //                     letterSpacing: 1,
                        //                     color: Color(0xFF3b3b3b),
                        //                   )),
                        //         )))
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      // Center(
                      //     child:
                      // selectedClasses.length > 0
                      //     ?
                      Flexible(
                        child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height - 280,
                                minHeight: 10),
                            child: ListView.builder(
                                itemCount: selectedClasses.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) => ListTile(
                                      title:
                                          Text(selectedClasses[index]['name']),
                                      subtitle: Text(
                                          '${selectedClasses[index]['timeCourse']}º período'),
                                      // dense: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      visualDensity:
                                          VisualDensity(vertical: -2.5),
                                    ))),
                        //   )
                        // ],
                      )
                      // : null
                      // )
                      ,
                      SizedBox(
                        height: 13,
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
                                            Color.fromARGB(
                                                255, 107, 185, 248))),
                                child: const Text(
                                  'SELECIONAR DISCIPLINAS CURSADAS',
                                  style: TextStyle(
                                      letterSpacing: 1, color: Colors.white),
                                ),
                                onPressed: () async {
                                  var result = await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SelectClassesPage(
                                      selectedClasses: data,
                                    );
                                  }));
                                  setState(() {
                                    print(result);
                                    data = result;
                                    dynamic data100 = [];
                                    result.forEach((d) => {
                                          if (d['isSelected']) {data100.add(d)}
                                        });
                                    selectedClasses = data100;
                                    updateData(widget.uid, result);
                                  });
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child:
                                  // selectedClasses.length > 0
                                  //     ?
                                  TextButton(
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
                                            selectedClasses: data)),
                              );
                            },
                          )
                              // : Text(''),
                              )
                        ],
                      )
                    ],
                    // ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Flexible(
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.0,
                                          // color: Color(0xFF3b3b3b),
                                          color: darkMode == true
                                              ? Colors.grey
                                              : Color(0xFF3b3b3b),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                10.0) //                 <--- border radius here
                                            )),
                                    child: Center(
                                      child:
                                          Text('NENHUMA DISCIPLINA SELECIONADA',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                                // color: Color(0xFF3b3b3b),
                                                color: darkMode == true
                                                    ? Colors.white
                                                    : Color(0xFF3b3b3b),
                                              )),
                                    )))
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
                                          EdgeInsets.fromLTRB(0, 20, 0, 20)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
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
                                      data = result;
                                      dynamic data100 = [];
                                      result.forEach((d) => {
                                            if (d['isSelected'])
                                              {data100.add(d)}
                                          });
                                      selectedClasses = data100;
                                      updateData(widget.uid, result);
                                    });
                                  }),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: TextButton(
                        //           style: ButtonStyle(
                        //               padding: MaterialStateProperty.all(
                        //                   EdgeInsets.fromLTRB(0, 20, 0, 20)),
                        //               backgroundColor:
                        //                   MaterialStateProperty.all(
                        //                       Colors.blue),
                        //               shape: MaterialStateProperty.all<
                        //                       RoundedRectangleBorder>(
                        //                   RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.circular(10),
                        //               )),
                        //               // padding: MaterialStateProperty.all(
                        //               //     EdgeInsets.fromLTRB(20, 20, 20, 20)),
                        //               overlayColor:
                        //                   // 0xFF8adeaf
                        //                   MaterialStateProperty.all(
                        //                       Color.fromARGB(
                        //                           255, 107, 185, 248))),
                        //           child: const Text(
                        //             'SAIR',
                        //             style: TextStyle(
                        //                 letterSpacing: 1, color: Colors.white),
                        //           ),
                        //           onPressed: () async {
                        //             authService.cleanToken();
                        //             Navigator.of(context).pushReplacement(
                        //                 MaterialPageRoute(
                        //                     builder: (context) => LoginPage()));
                        //             // setState(() {
                        //             //   print(result);
                        //             //   selectedClasses = result;
                        //             // });
                        //           }),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  )),
      ),
    );
  }
}
